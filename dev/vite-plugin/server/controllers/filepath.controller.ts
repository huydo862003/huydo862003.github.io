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
    (match) => [`concepts/${match[1]}/${match[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/flashcards\/([^/]+)$/,
    (match) => [`flashcards/${match[1]}/${match[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/phases\/([^/]+)$/,
    (match) => [`phases/${match[1]}/${match[2]}.md`],
  ],
  // books can be nested in subdirectories
  [
    /^\/journeys\/([^/]+)\/books\/([^/]+)$/,
    (match) => [
      `books/${match[2]}.md`,
      `books/${match[2]}/${match[2]}.md`,
    ],
  ],
  [
    /^\/journeys\/([^/]+)\/papers\/([^/]+)$/,
    (match) => [`papers/${match[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)\/blogs\/([^/]+)$/,
    (match) => [`blogs/${match[1]}/${match[2]}.md`],
  ],
  [
    /^\/journeys\/([^/]+)$/,
    (match) => [`journeys/${match[1]}.md`],
  ],
  [
    /^\/thoughts\/([^/]+)$/,
    (match) => [`thoughts/${match[1]}.md`],
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
    function_,
  ] of ROUTE_PATTERNS) {
    const match = route.match(re);
    if (!match) continue;
    const candidates = function_(match);
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
  return (request: Request, response: Response) => {
    const parsed = filepathQuery.safeParse(request.query);
    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    const filePath = resolveFilepath(manager, parsed.data.route);
    if (!filePath) return response.status(404).json({
      error: 'no match',
    });
    response.json({
      path: filePath,
    });
  };
}
