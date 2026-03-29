/**
 * Generate all static routes for SSG pre-rendering.
 * Based on vite-ssg's includedRoutes pattern:
 * https://github.com/antfu-collective/vite-ssg#custom-routes-to-render
 */
import fs from 'node:fs';
import path from 'node:path';

function slugsFromDir (dir: string): string[] {
  if (!fs.existsSync(dir)) return [];
  return fs.readdirSync(dir, { recursive: true })
    .filter((f) => String(f).endsWith('.md'))
    .map((f) => path.basename(String(f), '.md'));
}

function frontmatterField (filePath: string, field: string): string {
  const content = fs.readFileSync(filePath, 'utf-8');
  const match = content.match(new RegExp(`^${field}:\\s*(.+)`, 'm'));
  return match ? match[1].trim().replace(/^["']|["']$/g, '') : '';
}

export function generateRoutes (): string[] {
  const routes: string[] = [
    '/',
    '/thoughts',
    '/archived',
    '/journeys',
    '/graph',
  ];

  // Thoughts
  for (const slug of slugsFromDir('content/thoughts')) {
    routes.push(`/thoughts/${slug}`);
  }

  // Journeys + sub-pages
  const journeySlugs = slugsFromDir('content/journeys');
  for (const j of journeySlugs) {
    routes.push(`/journeys/${j}`);
    for (const sub of [
      'concepts',
      'flashcards',
      'phases',
      'books',
      'blogs',
      'papers',
    ]) {
      routes.push(`/journeys/${j}/${sub}`);
    }
  }

  // Concepts, flashcards, phases - grouped by journey
  const types = [
    'concepts',
    'flashcards',
    'phases',
  ] as const;
  for (const type of types) {
    for (const j of journeySlugs) {
      for (const slug of slugsFromDir(`content/${type}/${j}`)) {
        routes.push(`/journeys/${j}/${type}/${slug}`);
      }
    }
  }

  // Books - journey comes from frontmatter, not directory
  const walkBooks = (dir: string) => {
    if (!fs.existsSync(dir)) return;
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      if (entry.isDirectory()) {
        walkBooks(path.join(dir, entry.name));
      } else if (entry.name.endsWith('.md')) {
        const fp = path.join(dir, entry.name);
        const journey = frontmatterField(fp, 'journey');
        if (journey) {
          routes.push(`/journeys/${journey}/books/${path.basename(entry.name, '.md')}`);
        }
      }
    }
  };
  walkBooks('content/books');

  return routes;
}
