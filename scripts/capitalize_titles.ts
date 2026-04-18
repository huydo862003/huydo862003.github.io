#!/usr/bin/env node
// capitalizes first letter of title, question, name, and author fields in all content files

import { readFileSync, writeFileSync, readdirSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';
import yaml from 'js-yaml';

const ROOT = resolve(import.meta.dirname, '..');
const CONTENT_DIR = join(ROOT, 'content');
const FIELDS = ['title', 'question', 'name', 'author'];

function capitalizeFirst (s: string): string {
  if (!s) return s;
  return s.charAt(0).toUpperCase() + s.slice(1);
}

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

  let changed = false;
  for (const field of FIELDS) {
    const val = fm[field];
    if (typeof val !== 'string' || !val) continue;
    const capitalized = capitalizeFirst(val);
    if (capitalized !== val) {
      fm[field] = capitalized;
      changed = true;
    }
  }

  if (!changed) return;

  const newFm = yaml.dump(fm, { lineWidth: -1, quotingType: '"', forceQuotes: false }).trimEnd();
  writeFileSync(path, `---\n${newFm}\n---\n${fmMatch[2]}`);
  console.log(`  fixed: ${path.replace(ROOT + '/', '')}`);
}

const files = walk(CONTENT_DIR);
console.log(`Checking ${files.length} files...`);
for (const f of files) processFile(f);
console.log('Done.');
