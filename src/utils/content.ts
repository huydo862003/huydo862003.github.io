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

  const LANG_IMPORTS: [string, () => Promise<{
    default: unknown;
  }>][] = [
    [
      'haskell',
      () => import('highlight.js/lib/languages/haskell'),
    ],
    [
      'ocaml',
      () => import('highlight.js/lib/languages/ocaml'),
    ],
    [
      'scheme',
      () => import('highlight.js/lib/languages/scheme'),
    ],
    [
      'python',
      () => import('highlight.js/lib/languages/python'),
    ],
    [
      'javascript',
      () => import('highlight.js/lib/languages/javascript'),
    ],
    [
      'typescript',
      () => import('highlight.js/lib/languages/typescript'),
    ],
    [
      'bash',
      () => import('highlight.js/lib/languages/bash'),
    ],
    [
      'css',
      () => import('highlight.js/lib/languages/css'),
    ],
  ];

  const [
    {
      default: MarkdownIt,
    },
    {
      default: anchor,
    },
    {
      default: container,
    },
    {
      default: texmath,
    },
    {
      default: katex,
    },
    {
      default: hljs,
    },
    ...langMods
  ] = await Promise.all([
    import('markdown-it'),
    import('markdown-it-anchor'),
    import('markdown-it-container'),
    import('markdown-it-texmath'),
    import('katex'),
    import('highlight.js/lib/core'),
    ...LANG_IMPORTS.map(([
      , function_,
    ]) => function_()),
    // Side-effect CSS imports (no value needed)
    import('katex/dist/katex.min.css'),
    import('highlight.js/styles/github.css'),
  ]);

  type LanguageFunction = Parameters<typeof hljs.registerLanguage>[1];
  LANG_IMPORTS.forEach(([name], index) => hljs.registerLanguage(name, (langMods[index] as {
    default: LanguageFunction;
  }).default));
  hljs.registerAliases([
    'coq',
    'rocq',
    'v',
  ], {
    languageName: 'ocaml',
  });

  const md = new MarkdownIt({
    html: true,
    linkify: true,
    typographer: false,
    highlight (string_: string, lang: string) {
      if (lang && hljs.getLanguage(lang)) {
        try {
          return hljs.highlight(string_, {
            language: lang,
          }).value;
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
      render (tokens: {
        nesting: number;
      }[], index: number) {
        return tokens[index].nesting === 1
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
    const source = state.src.slice(state.pos);
    const match = source.match(/^\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/);
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

  for (const concept of allConcepts) {
    const slug = concept._meta.fileName.replace('.md', '');
    const journey = (concept as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/concepts/${slug}`,
      title: concept.title,
    });
  }

  for (const book of allBooks) {
    const slug = book._meta.fileName.replace('.md', '');
    const journey = (book as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/books/${slug}`,
      title: book.title,
    });
  }

  for (const flashcard of allFlashcards) {
    const slug = flashcard._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/journeys/plt/flashcards/${slug}`,
      title: flashcard.question,
    });
  }

  for (const phase of allPhases) {
    const slug = phase._meta.fileName.replace('.md', '');
    const journey = (phase as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/phases/${slug}`,
      title: phase.title,
    });
  }

  for (const index of allJourneys) {
    const slug = index._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/journeys/${slug}`,
      title: index.title,
    });
  }

  for (const thought of allThoughts) {
    const slug = thought._meta.fileName.replace('.md', '');
    map.set(slug, {
      to: `/thoughts/${slug}`,
      title: thought.title,
    });
  }

  for (const blog of allBlogs) {
    const slug = blog._meta.fileName.replace('.md', '');
    const journey = (blog as Record<string, unknown>).journey as string || '';
    map.set(slug, {
      to: `/journeys/${journey}/blogs/${slug}`,
      title: blog.title,
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
for (const [
  path,
  loader,
] of Object.entries(bodyGlob)) {
  slugToLoader.set(slugFromPath(path), loader);
}

export async function loadContent (slug: string): Promise<string> {
  const cached = htmlCache.get(slug);
  if (cached) return cached;

  const loader = slugToLoader.get(slug);
  if (!loader) return '';

  const raw = await loader() as string;
  const {
    rawContent,
  } = parseFrontMatter(raw);
  if (!rawContent.trim()) return '';
  const html = await renderMarkdown(rawContent);
  htmlCache.set(slug, html);
  return html;
}

export function getCachedContent (slug: string): string {
  return htmlCache.get(slug) ?? '';
}
