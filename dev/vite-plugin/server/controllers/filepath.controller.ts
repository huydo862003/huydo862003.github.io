import {
  join, relative,
} from 'node:path';
import {
  existsSync, readdirSync, statSync,
} from 'node:fs';
import type {
  Request, Response,
} from 'express';
import {
  z,
} from 'zod';
import type {
  ContentManager,
} from '../../../core/contentManager';

const filepathQuery = z.object({
  route: z.string().min(1),
});

const ROUTE_PATTERNS: [RegExp, (m: RegExpMatchArray) => string[]][] = [
  [
    /^\/journeys\/([^/]+)\/concepts\/([^/]+)$/,
    (m) => [`concepts/${m[1]}/${m[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/flashcards\/([^/]+)$/,
    (m) => [`flashcards/${m[1]}/${m[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/phases\/([^/]+)$/,
    (m) => [`phases/${m[1]}/${m[2]}.md`],
  ],
  // books can be nested in subdirectories
  [
    /^\/journeys\/([^/]+)\/books\/([^/]+)$/,
    (m) => [
      `books/${m[2]}.md`,
      `books/${m[2]}/${m[2]}.md`,
    ],
  ],
  [
    /^\/journeys\/([^/]+)\/papers\/([^/]+)$/,
    (m) => [`papers/${m[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/blogs\/([^/]+)$/,
    (m) => [`blogs/${m[1]}/${m[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)$/,
    (m) => [`journeys/${m[1]}.md`],
  ],
  [
    /^\/thoughts\/([^/]+)$/,
    (m) => [`thoughts/${m[1]}.md`],
  ],
];

function findFile (directory: string, filename: string): string | undefined {
  if (!existsSync(directory)) return undefined;
  for (const entry of readdirSync(directory)) {
    const abs = join(directory, entry);
    let stat;
    try {
      stat = statSync(abs);
    } catch {
      continue;
    }
    if (stat.isDirectory()) {
      const result = findFile(abs, filename);
      if (result) return result;
    } else if (entry === filename) {
      return abs;
    }
  }
  return undefined;
}

function resolveFilepath (manager: ContentManager, route: string): string | undefined {
  for (const [
    re,
    fn,
  ] of ROUTE_PATTERNS) {
    const m = route.match(re);
    if (!m) continue;
    const candidates = fn(m);
    for (const candidate of candidates) {
      if (manager.contentExists(candidate)) return candidate;
    }
    const contentType = candidates[0].split('/')[0];
    const slug = candidates[0].split('/').pop() ?? '';
    const found = findFile(join(manager.root, contentType), slug);
    if (found) return relative(manager.root, found);
  }
  return undefined;
}

export function lookup (manager: ContentManager) {
  return (req: Request, res: Response) => {
    const parsed = filepathQuery.safeParse(req.query);
    if (!parsed.success) return res.status(400).json({
      error: parsed.error.issues[0].message,
    });
    const filePath = resolveFilepath(manager, parsed.data.route);
    if (!filePath) return res.status(404).json({
      error: 'no match',
    });
    res.json({
      path: filePath,
    });
  };
}
