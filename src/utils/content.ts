import fm from 'front-matter';
import GithubSlugger from 'github-slugger';
import type MarkdownItType from 'markdown-it';
import {
  allConcepts, allBooks, allFlashcards, allPhases, allJourneys, allThoughts, allBlogs,
} from 'content-collections';

const slugger = new GithubSlugger();

export function slugify (input: string): string {
  slugger.reset();
  return slugger.slug(input);
}

export function slugFromPath (filePath: string): string {
  return (filePath.split('/').pop() ?? '').replace('.md', '');
}

let mdInstance: MarkdownItType | undefined;

async function getMd () {
  if (mdInstance) return mdInstance;

  const LANG_IMPORTS: [string, () => Promise<{ default: unknown }>][] = [
    ['haskell', () => import('highlight.js/lib/languages/haskell')],
    ['ocaml', () => import('highlight.js/lib/languages/ocaml')],
    ['scheme', () => import('highlight.js/lib/languages/scheme')],
    ['python', () => import('highlight.js/lib/languages/python')],
    ['javascript', () => import('highlight.js/lib/languages/javascript')],
    ['typescript', () => import('highlight.js/lib/languages/typescript')],
    ['bash', () => import('highlight.js/lib/languages/bash')],
    ['css', () => import('highlight.js/lib/languages/css')],
  ];

  const [
    { default: MarkdownIt },
    { default: anchor },
    { default: container },
    { default: texmath },
    { default: katex },
    { default: hljs },
    ...langMods
  ] = await Promise.all([
    import('markdown-it'),
    import('markdown-it-anchor'),
    import('markdown-it-container'),
    import('markdown-it-texmath'),
    import('katex'),
    import('highlight.js/lib/core'),
    ...LANG_IMPORTS.map(([, fn]) => fn()),
    // Side-effect CSS imports (no value needed)
    import('katex/dist/katex.min.css'),
    import('highlight.js/styles/github.css'),
  ]);

  type LanguageFn = Parameters<typeof hljs.registerLanguage>[1];
  LANG_IMPORTS.forEach(([name], i) => hljs.registerLanguage(name, (langMods[i] as { default: LanguageFn }).default));
  hljs.registerAliases([
    'coq',
    'rocq',
    'v',
  ], { languageName: 'ocaml' });

  const md = new MarkdownIt({
    html: true,
    linkify: true,
    typographer: false,
    highlight (str: string, lang: string) {
      if (lang && hljs.getLanguage(lang)) {
        try {
          return hljs.highlight(str, { language: lang }).value;
        } catch { /* fall through */ }
      }
      return '';
    },
  });

  md.use(texmath, {
    engine: katex,
    delimiters: 'dollars',
    katexOptions: {
      throwOnError: false,
      strict: false,
      trust: true,
    },
  });

  const CALLOUT_TYPES = [
    'tip',
    'warning',
    'note',
    'key',
    'question',
    'insight',
    'important',
  ];
  for (const type of CALLOUT_TYPES) {
    md.use(container, type, {
      render (tokens: { nesting: number }[], idx: number) {
        return tokens[idx].nesting === 1
          ? `<div class="callout callout-${type}"><span class="callout-label">${type}</span>\n`
          : '</div>\n';
      },
    });
  }

  md.use(anchor, {
    slugify,
    permalink: anchor.permalink.ariaHidden({
      placement: 'before',
      symbol: '#',
      class: 'heading-anchor',
    }),
  });

  // Wiki-link [[slug]] or [[slug|label]] resolver
  const crossLinks = buildCrossLinks();
  md.inline.ruler.push('wiki_link', (state) => {
    const src = state.src.slice(state.pos);
    const match = src.match(/^\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/);
    if (!match) return false;

    const slug = match[1].trim();
    const label = match[2]?.trim();
    const entry = crossLinks.get(slug);

    const tokenO = state.push('html_inline', '', 0);
    if (entry) {
      tokenO.content = `<a href="${entry.to}" class="cross-link">${label ?? entry.title}</a>`;
    } else {
      tokenO.content = `<span class="cross-link-missing">${label ?? slug}</span>`;
    }

    state.pos += match[0].length;
    return true;
  });

  mdInstance = md;
  return md;
}

interface CrossLink {
  to: string;
  title: string;
}

function buildCrossLinks (): Map<string, CrossLink> {
  const map = new Map<string, CrossLink>();

  for (const c of allConcepts) {
    const slug = c._meta.fileName.replace('.md', '');
    const journey = (c as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/concepts/${slug}`,
      title: c.title,
    });
  }

  for (const b of allBooks) {
    const slug = b._meta.fileName.replace('.md', '');
    const journey = (b as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/books/${slug}`,
      title: b.title,
    });
  }

  for (const f of allFlashcards) {
    const slug = f._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/journeys/plt/flashcards/${slug}`,
      title: f.question,
    });
  }

  for (const p of allPhases) {
    const slug = p._meta.fileName.replace('.md', '');
    const journey = (p as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/phases/${slug}`,
      title: p.title,
    });
  }

  for (const j of allJourneys) {
    const slug = j._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/journeys/${slug}`,
      title: j.title,
    });
  }

  for (const t of allThoughts) {
    const slug = t._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/thoughts/${slug}`,
      title: t.title,
    });
  }

  for (const b of allBlogs) {
    const slug = b._meta.fileName.replace('.md', '');
    const journey = (b as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/blogs/${slug}`,
      title: b.title,
    });
  }

  return map;
}

export async function renderMarkdown (raw: string): Promise<string> {
  const md = await getMd();
  return md.render(raw);
}

export function parseFrontMatter (raw: string): {
  frontMatter: Record<string, unknown>;
  rawContent: string;
} {
  const {
    attributes, body,
  } = fm<Record<string, unknown>>(raw);
  return {
    frontMatter: attributes,
    rawContent: body,
  };
}

const htmlCache = new Map<string, string>();
const bodyGlob = import.meta.glob('/content/**/*.md', {
  eager: false,
  query: '?raw',
  import: 'default',
});

const slugToLoader = new Map<string, () => Promise<unknown>>();
for (const [path, loader] of Object.entries(bodyGlob)) {
  slugToLoader.set(slugFromPath(path), loader);
}

export async function loadContent (slug: string): Promise<string> {
  const cached = htmlCache.get(slug);
  if (cached) return cached;

  const loader = slugToLoader.get(slug);
  if (!loader) return '';

  const raw = await loader() as string;
  const { rawContent } = parseFrontMatter(raw);
  if (!rawContent.trim()) return '';
  const html = await renderMarkdown(rawContent);
  htmlCache.set(slug, html);
  return html;
}

export function getCachedContent (slug: string): string {
  return htmlCache.get(slug) ?? '';
}
