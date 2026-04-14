import {
  writeFileSync, existsSync,
} from 'node:fs';
import {
  resolve,
} from 'node:path';

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
  author: string;
}): void {
  const slug = slugify(opts.title);
  const filePath = resolve(import.meta.dirname, '../../content', opts.contentDir, `${slug}.md`);

  if (existsSync(filePath)) {
    console.error(`Already exists: ${filePath}`);
    process.exit(1);
  }

  const today = new Date().toISOString()
    .slice(0, 10);
  const author = opts.author ?? 'hdnax';
  const content = `---\npublished: true\nauthor: ${author}\ncreatedAt: "${today}"\nupdatedAt: "${today}"\n${opts.frontMatter}\n---\n\n`;
  writeFileSync(filePath, content);
  console.log(`Created: content/${opts.contentDir}/${slug}.md`);
}
