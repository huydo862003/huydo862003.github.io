import {
  writeFileSync, existsSync,
} from 'fs';
import { resolve } from 'path';

export function slugify (input: string): string {
  return input
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

export function scaffoldContent (opts: {
  contentDir: string;
  title: string;
  frontMatter: string;
}): void {
  const slug = slugify(opts.title);
  const filePath = resolve(import.meta.dirname, '../../content', opts.contentDir, `${slug}.md`);

  if (existsSync(filePath)) {
    console.error(`Already exists: ${filePath}`);
    process.exit(1);
  }

  const content = `---\n${opts.frontMatter}\n---\n\n`;
  writeFileSync(filePath, content);
  console.log(`Created: content/${opts.contentDir}/${slug}.md`);
}
