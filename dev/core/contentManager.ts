import yaml from 'js-yaml';
import {
  RootJail,
} from './rootJail';
import {
  ContentType, type TreeNode, type JourneyTree, type JourneyGroup, type ContentItem,
} from './types';

export {
  ContentType,
} from './types';
export type {
  TreeNode,
} from './types';

type Frontmatter = Record<string, unknown>;

function today () {
  return new Date().toISOString()
    .slice(0, 10);
}

function toMarkdown (fm: Frontmatter, body = ''): string {
  const lines = ['---'];
  for (const [
    key,
    val,
  ] of Object.entries(fm)) {
    if (Array.isArray(val)) {
      lines.push(val.length === 0 ? `${key}: []` : `${key}:\n${val.map((v) => `  - "${v}"`).join('\n')}`);
    } else if (typeof val === 'boolean') {
      lines.push(`${key}: ${val}`);
    } else if (typeof val === 'number') {
      lines.push(`${key}: ${val}`);
    } else {
      lines.push(`${key}: "${val}"`);
    }
  }
  lines.push('---', '', body);
  return lines.join('\n');
}

function baseFrontmatter (author = ''): Frontmatter {
  return {
    published: false,
    author,
    createdAt: today(),
    updatedAt: today(),
  };
}

function slugify (title: string): string {
  return title.toLowerCase().replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

// domain-level API for content operations
// uses two jails: content for .md files, schemas for .schemas/
// no direct fs imports
export class ContentManager {
  private readonly contentJail: RootJail;
  private readonly schemaJail: RootJail;
  private readonly fmCache = new Map<string, Record<string, unknown>>();

  constructor (root: string) {
    this.contentJail = new RootJail(root);
    this.schemaJail = new RootJail(`${root}/.schemas`);
  }

  private getCachedFrontmatter (path: string): Record<string, unknown> {
    const cached = this.fmCache.get(path);
    if (cached) return cached;
    const raw = this.contentJail.readFileSync(path);
    const fm = this.parseFrontmatter(raw);
    this.fmCache.set(path, fm);
    return fm;
  }

  private invalidateCache (path: string) {
    this.fmCache.delete(path);
  }

  get root () {
    return this.contentJail.root;
  }

  // reading + updating existing content

  getContent (path: string): { path: string;
    content: string; } {
    return {
      path,
      content: this.contentJail.readFileSync(path),
    };
  }

  updateContent (path: string, content: string): void {
    if (!this.contentJail.existsSync(path)) throw new Error(`not found: ${path}`);
    this.contentJail.unlinkSync(path);
    this.contentJail.writeFileSync(path, content);
    this.invalidateCache(path);
  }

  deleteContent (path: string): void {
    this.contentJail.unlinkSync(path);
    this.invalidateCache(path);
  }

  contentExists (path: string): boolean {
    return this.contentJail.existsSync(path);
  }

  // content creation - one method per type

  createJourney (title: string, options: {
    author?: string;
    status?: string;
    tags?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Journeys}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      status: options.status ?? 'active',
      tags: options.tags ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createConcept (journey: string, title: string, options: {
    author?: string;
    status?: string;
    tags?: string[];
    books?: string[];
    dependsOn?: string[];
    blocks?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Concepts}/${journey}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      journey,
      status: options.status ?? 'learning',
      tags: options.tags ?? [],
      books: options.books ?? [],
      dependsOn: options.dependsOn ?? [],
      blocks: options.blocks ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createFlashcard (journey: string, question: string, options: {
    author?: string;
    deck?: string;
    tags?: string[];
    concepts?: string[];
    books?: string[];
  } = {}): string {
    const slug = slugify(question);
    const path = `${ContentType.Flashcards}/${journey}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      question,
      deck: options.deck ?? 'general',
      tags: options.tags ?? [],
      concepts: options.concepts ?? [],
      books: options.books ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createPhase (journey: string, title: string, options: {
    author?: string;
    status?: string;
    order?: number;
    books?: string[];
    concepts?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Phases}/${journey}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      journey,
      status: options.status ?? 'on-hold',
      order: options.order ?? 0,
      books: options.books ?? [],
      concepts: options.concepts ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createBook (title: string, options: {
    author?: string;
    journey?: string;
    isbn?: string;
    url?: string;
    cover?: string;
    tags?: string[];
    concepts?: string[];
    parent?: string;
    children?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Books}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      date: '',
      journey: options.journey ?? '',
      description: '',
      isbn: options.isbn ?? '',
      url: options.url ?? '',
      cover: options.cover ?? '',
      tags: options.tags ?? [],
      concepts: options.concepts ?? [],
      parent: options.parent ?? '',
      children: options.children ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createBlog (journey: string, title: string, options: {
    author?: string;
    url?: string;
    site?: string;
    tags?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Blogs}/${journey}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      url: options.url ?? '',
      journey,
      site: options.site ?? '',
      latestPost: '',
      lastChecked: '',
      posts: [],
      tags: options.tags ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createPaper (title: string, options: {
    author?: string;
    authors?: string[];
    year?: string;
    venue?: string;
    url?: string;
    journey?: string;
    tags?: string[];
    concepts?: string[];
    status?: string;
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Papers}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      authors: options.authors ?? [],
      year: options.year ?? '',
      venue: options.venue ?? '',
      url: options.url ?? '',
      journey: options.journey ?? '',
      tags: options.tags ?? [],
      concepts: options.concepts ?? [],
      status: options.status ?? 'to-read',
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createThought (title: string, options: {
    author?: string;
    description?: string;
    tags?: string[];
    concepts?: string[];
    journeys?: string[];
  } = {}): string {
    const slug = slugify(title);
    const path = `${ContentType.Thoughts}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(options.author),
      title,
      date: today(),
      description: options.description ?? '',
      tags: options.tags ?? [],
      archived: false,
      concepts: options.concepts ?? [],
      journeys: options.journeys ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  createAuthor (name: string, options: {
    bio?: string;
    url?: string;
    dateOfBirth?: string;
    origin?: string;
    education?: string[];
    interests?: string[];
    tags?: string[];
  } = {}): string {
    const slug = slugify(name);
    const path = `${ContentType.Authors}/${slug}.md`;
    const fm = {
      ...baseFrontmatter(),
      name,
      bio: options.bio ?? '',
      url: options.url ?? '',
      dateOfBirth: options.dateOfBirth ?? '',
      origin: options.origin ?? '',
      education: options.education ?? [],
      interests: options.interests ?? [],
      tags: options.tags ?? [],
    };
    this.createFile(path, toMarkdown(fm));
    return path;
  }

  // schemas

  schemas (): Record<string, unknown> {
    const schemas: Record<string, unknown> = {};
    let files: string[];
    try {
      files = this.schemaJail.readdirSync('.');
    } catch {
      return schemas;
    }
    for (const filename of files) {
      if (!filename.endsWith('.yaml') && !filename.endsWith('.yml')) continue;
      const name = filename.replace(/\.ya?ml$/, '');
      schemas[name] = yaml.load(this.schemaJail.readFileSync(filename));
    }
    return schemas;
  }

  listContent (contentType: string): ContentItem[] {
    const displayField = this.getDisplayField(contentType);
    return this.traverseContent(contentType, (path, slug, fm) => ({
      slug,
      title: fm[displayField] ? String(fm[displayField]) : slug.replace(/-/g, ' '),
      path,
    }));
  }

  private getDisplayField (contentType: string): string {
    const allSchemas = this.schemas() as Record<string, { displayName?: string }>;
    return allSchemas[contentType]?.displayName ?? 'title';
  }

  private traverseContent<T> (contentType: string, transform: (path: string, slug: string, fm: Record<string, unknown>) => T | null): T[] {
    const results: T[] = [];
    const collect = (dir: string) => {
      let entries: string[];
      try { entries = this.contentJail.readdirSync(dir); } catch { return; }
      for (const entry of entries) {
        const full = dir === '.' ? entry : `${dir}/${entry}`;
        if (!full.startsWith(contentType)) continue;
        let stat;
        try { stat = this.contentJail.statSync(full); } catch { continue; }
        if (stat.isDirectory()) { collect(full); continue; }
        if (!entry.endsWith('.md')) continue;
        const slug = entry.replace(/\.md$/, '');
        let fm: Record<string, unknown> = {};
        try { fm = this.getCachedFrontmatter(full); } catch { /* empty fm */ }
        const item = transform(full, slug, fm);
        if (item) results.push(item);
      }
    };
    collect(contentType);
    return results;
  }

  // journey-centric tree
  journeyTree (): JourneyTree {
    const allSchemas = this.schemas() as Record<string, { displayName?: string }>;
    const GROUPED_TYPES = [ContentType.Concepts, ContentType.Flashcards, ContentType.Phases, ContentType.Blogs] as const;
    const FM_GROUPED_TYPES = [ContentType.Books, ContentType.Papers] as const;
    const STANDALONE_TYPES = [ContentType.Thoughts, ContentType.Authors] as const;

    // load journeys
    const journeyItems = this.listContent('journeys');
    const journeys: JourneyGroup[] = journeyItems.map((j) => ({
      slug: j.slug,
      title: j.title,
      path: j.path,
      resources: {} as Record<string, ContentItem[]>,
    }));

    // dir-grouped types: concepts/{journey}/, flashcards/{journey}/, etc.
    for (const type of GROUPED_TYPES) {
      const displayField = allSchemas[type]?.displayName ?? 'title';
      for (const journey of journeys) {
        const dir = `${type}/${journey.slug}`;
        const items: ContentItem[] = [];
        let entries: string[];
        try { entries = this.contentJail.readdirSync(dir); } catch { continue; }
        for (const entry of entries) {
          if (!entry.endsWith('.md')) continue;
          const path = `${dir}/${entry}`;
          const slug = entry.replace(/\.md$/, '');
          let title = slug.replace(/-/g, ' ');
          try {
            const fm = this.getCachedFrontmatter(path);
            if (fm[displayField]) title = String(fm[displayField]);
          } catch { /* use slug */ }
          items.push({ slug, title, path });
        }
        if (items.length) journey.resources[type] = items;
      }
    }

    // frontmatter-grouped types: books, papers (have `journey` field)
    for (const type of FM_GROUPED_TYPES) {
      const all = this.listContentWithJourney(type);
      for (const item of all) {
        const journey = journeys.find((j) => j.slug === item.journey);
        if (!journey) continue;
        if (!journey.resources[type]) journey.resources[type] = [];
        journey.resources[type].push({ slug: item.slug, title: item.title, path: item.path });
      }
    }

    // standalone types
    const standalone: Record<string, ContentItem[]> = {};
    for (const type of STANDALONE_TYPES) {
      const items = this.listContent(type);
      if (items.length) standalone[type] = items;
    }

    return { journeys, standalone };
  }

  private listContentWithJourney (contentType: string): (ContentItem & { journey: string })[] {
    const displayField = this.getDisplayField(contentType);
    return this.traverseContent(contentType, (path, slug, fm) => {
      const journey = fm.journey ? String(fm.journey) : '';
      if (!journey) return null;
      return {
        slug,
        title: fm[displayField] ? String(fm[displayField]) : slug.replace(/-/g, ' '),
        path,
        journey,
      };
    });
  }

  // tree

  tree (relativePath = '.'): TreeNode[] {
    let entries: string[];
    try {
      entries = this.contentJail.readdirSync(relativePath);
    } catch {
      return [];
    }
    entries.sort();
    const nodes: TreeNode[] = [];
    for (const entry of entries) {
      if (entry.startsWith('.')) continue;
      if (entry.startsWith('_')) continue;
      const childPath = relativePath === '.' ? entry : `${relativePath}/${entry}`;
      let stat;
      try {
        stat = this.contentJail.statSync(childPath);
      } catch {
        continue;
      }
      if (stat.isDirectory()) {
        nodes.push({
          name: entry,
          path: childPath,
          type: 'dir',
          children: this.tree(childPath),
        });
      } else if (entry.endsWith('.md')) {
        nodes.push({
          name: entry,
          path: childPath,
          type: 'file',
        });
      }
    }
    return nodes;
  }

  // private

  private parseFrontmatter (raw: string): Record<string, unknown> {
    const fmBlock = raw.indexOf('---\n');
    if (fmBlock !== 0) return {};
    const end = raw.indexOf('\n---', 4);
    if (end === -1) return {};
    const fm: Record<string, unknown> = {};
    try {
      const parsed = yaml.load(raw.slice(4, end));
      if (parsed && typeof parsed === 'object') Object.assign(fm, parsed);
    } catch { /* invalid yaml */ }
    return fm;
  }

  private createFile (path: string, content: string): void {
    const parent = path.substring(0, path.lastIndexOf('/'));
    if (parent && !this.contentJail.existsSync(parent)) this.contentJail.mkdirSync(parent);
    this.contentJail.writeFileSync(path, content);
  }
}
