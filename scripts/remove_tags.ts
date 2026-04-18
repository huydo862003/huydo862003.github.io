#!/usr/bin/env node
// removes specified tags from all content files
// usage: tsx scripts/remove_tags.ts [tags...]
// default: PLT, textbook, design, chapter, blog

import { readFileSync, writeFileSync, readdirSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';
import yaml from 'js-yaml';

const ROOT = resolve(import.meta.dirname, '..');
const CONTENT_DIR = join(ROOT, 'content');
const REMOVE_TAGS = process.argv.length > 2
  ? process.argv.slice(2)
  : ['PLT', 'textbook', 'design', 'chapter', 'blog'];

function walk (dir: string): string[] {
  const results: string[] = [];
  for (const entry of readdirSync(dir)) {
    if (entry.startsWith('.')) continue;
    const full = join(dir, entry);
    let stat;
    try { stat = statSync(full); } catch { continue; }
    if (stat.isDirectory()) results.push(...walk(full));
    else if (entry.endsWith('.md')) results.push(full);
  }
  return results;
}

function processFile (path: string) {
  const raw = readFileSync(path, 'utf-8');
  const fmMatch = raw.match(/^---\n([\s\S]*?)\n---\n?([\s\S]*)$/);
  if (!fmMatch) return;

  let fm: Record<string, unknown>;
  try { fm = yaml.load(fmMatch[1]) as Record<string, unknown>; }
  catch { return; }

  const tags = fm.tags;
  if (!Array.isArray(tags)) return;

  const filtered = tags.filter((t) => !REMOVE_TAGS.includes(String(t)));
  if (filtered.length === tags.length) return;

  fm.tags = filtered;
  const newFm = yaml.dump(fm, { lineWidth: -1, quotingType: '"', forceQuotes: false }).trimEnd();
  const output = `---\n${newFm}\n---\n${fmMatch[2]}`;
  writeFileSync(path, output);
  console.log(`  ${tags.length - filtered.length} tag(s) removed: ${path.replace(ROOT + '/', '')}`);
}

const files = walk(CONTENT_DIR);
console.log(`Removing tags [${REMOVE_TAGS.join(', ')}] from ${files.length} files...`);
let count = 0;
for (const f of files) {
  const before = readFileSync(f, 'utf-8');
  processFile(f);
  if (readFileSync(f, 'utf-8') !== before) count++;
}
console.log(`Done. ${count} file(s) modified.`);
