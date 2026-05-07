/**
 * Generate all static routes for SSG pre-rendering.
 * Based on vite-ssg's includedRoutes pattern:
 * https://github.com/antfu-collective/vite-ssg#custom-routes-to-render
 */
import fs from 'node:fs';
import path from 'node:path';

function slugsFromDirectory (directory: string): string[] {
  if (!fs.existsSync(directory)) return [];
  return fs.readdirSync(directory, {
    recursive: true,
  })
    .filter((file) => String(file).endsWith('.md'))
    .map((file) => path.basename(String(file), '.md'));
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
    '/reads',
    '/graph',
  ];

  for (const slug of slugsFromDirectory('content/thoughts')) {
    routes.push(`/thoughts/${slug}`);
  }

  const journeySlugs = slugsFromDirectory('content/journeys');
  for (const index of journeySlugs) {
    routes.push(`/journeys/${index}`);
    for (const sub of [
      'concepts',
      'flashcards',
      'phases',
      'books',
      'blogs',
      'papers',
    ]) {
      routes.push(`/journeys/${index}/${sub}`);
    }
  }

  const types = [
    'concepts',
    'flashcards',
    'phases',
  ] as const;
  for (const type of types) {
    for (const index of journeySlugs) {
      for (const slug of slugsFromDirectory(`content/${type}/${index}`)) {
        routes.push(`/journeys/${index}/${type}/${slug}`);
      }
    }
  }

  // Books - journey comes from frontmatter, not directory
  const walkBooks = (directory: string) => {
    if (!fs.existsSync(directory)) return;
    for (const entry of fs.readdirSync(directory, {
      withFileTypes: true,
    })) {
      if (entry.isDirectory()) {
        walkBooks(path.join(directory, entry.name));
      } else if (entry.name.endsWith('.md')) {
        const fp = path.join(directory, entry.name);
        const journey = frontmatterField(fp, 'journey');
        if (journey) {
          routes.push(`/journeys/${journey}/books/${path.basename(entry.name, '.md')}`);
        }
      }
    }
  };
  walkBooks('content/books');

  // Papers - journey comes from frontmatter
  for (const entry of fs.readdirSync('content/papers', {
    withFileTypes: true,
  }).filter((entry) => entry.isFile() && entry.name.endsWith('.md'))) {
    const fp = path.join('content/papers', entry.name);
    const journey = frontmatterField(fp, 'journey');
    if (journey) {
      routes.push(`/journeys/${journey}/papers/${path.basename(entry.name, '.md')}`);
    }
  }

  return routes;
}
