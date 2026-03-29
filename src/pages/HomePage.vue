<template>
  <div>
    <section class="main-section page">
      <div class="hero">
        <h1>Scrambled Kitchen</h1>
        <p>
          Scrambled thoughts. Scrambled journeys. And scrambled eggs.

          Just batch migrated from Notion for easier customization & decentralized backups, so things may currently be scrambled up a bit.
        </p>
      </div>

      <div class="section">
        <h2>
          <router-link
            to="/thoughts"
            class="section-link"
          >
            Scrambled Thoughts
          </router-link>
        </h2>
        <ul
          v-if="recentPosts.length"
          class="list"
        >
          <li
            v-for="post in recentPosts"
            :key="post.slug"
            class="item"
          >
            <div class="item-body">
              <div class="item-row">
                <span class="date">{{ post.date }}</span>
                <router-link
                  :to="`/thoughts/${post.slug}`"
                  class="item-link"
                >
                  {{ post.title }}
                </router-link>
              </div>
              <span
                v-if="post.description"
                class="desc"
              >{{ post.description }}</span>
            </div>
          </li>
        </ul>
        <p
          v-else
          class="empty"
        >
          No thoughts yet. Still scrambling.
        </p>
      </div>

      <div class="section">
        <h2>
          <router-link
            to="/journeys"
            class="section-link"
          >
            Scrambled Journeys
          </router-link>
        </h2>
        <ul
          v-if="journeys.length"
          class="list"
        >
          <li
            v-for="j in journeys"
            :key="j.slug"
            class="item"
          >
            <div class="item-body">
              <div class="item-row">
                <router-link
                  :to="`/journeys/${j.slug}`"
                  class="item-link"
                >
                  {{ j.title }}
                </router-link>
                <span :class="`status-${j.status}`">{{ j.status }}</span>
              </div>
              <span
                v-if="j.description"
                class="desc"
              >{{ j.description }}</span>
            </div>
          </li>
        </ul>
        <p
          v-else
          class="empty"
        >
          No journeys yet. Still scrambling with the baggage.
        </p>
      </div>
      <div class="section">
        <h2>Scrambled Projects &amp; Research</h2>
        <ul class="list">
          <li
            v-for="p in projects"
            :key="p.name"
            class="item"
          >
            <div class="item-body">
              <div class="project-header">
                <a
                  :href="p.repo"
                  target="_blank"
                  rel="noopener"
                  class="item-link"
                >{{ p.name }}</a>
                <span :class="`status-${p.status}`">{{ p.status }}</span>
              </div>
              <div
                v-if="p.npm || p.docs"
                class="project-links"
              >
                <a
                  v-if="p.npm"
                  :href="p.npm"
                  target="_blank"
                  rel="noopener"
                  class="plink"
                >
                  <PhPackage :size="12" /> npm
                </a>
                <a
                  v-if="p.docs"
                  :href="p.docs"
                  target="_blank"
                  rel="noopener"
                  class="plink"
                >
                  <PhReadCvLogo :size="12" /> docs
                </a>
              </div>
              <span class="desc">{{ p.desc }}</span>
              <div
                v-if="p.links?.length"
                class="project-links"
              >
                <a
                  v-for="l in p.links"
                  :key="l.url"
                  :href="l.url"
                  target="_blank"
                  rel="noopener"
                  class="plink"
                >
                  <PhNewspaper :size="12" /> {{ l.label }}
                </a>
              </div>
              <div class="project-tags">
                <span
                  v-for="t in p.tags"
                  :key="t"
                  class="cat-tag"
                >{{ t }}</span>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </section>

    <div class="section-sep" />

    <section class="graph-section">
      <div class="reads-panel">
        <h2 class="reads-heading">
          Scrambled Reads
        </h2>
        <SFilterBar
          :groups="filterGroups"
          :model-values="filterValues"
          class="mb-4"
          @update:model-values="onFilterUpdate"
        />
        <ul class="reads-list">
          <li
            v-for="item in pagedReads"
            :key="`${item.type}-${item.slug}`"
            class="reads-item"
          >
            <span :class="`reads-type reads-type-${item.type}`">{{ item.type }}</span>
            <div class="reads-item-body">
              <a
                v-if="item.url"
                :href="item.url"
                target="_blank"
                rel="noopener"
                class="reads-item-title"
              >{{ item.title }}</a>
              <span
                v-else
                class="reads-item-title no-link"
              >{{ item.title }}</span>
              <span
                v-if="item.meta"
                class="reads-item-meta"
              >{{ item.meta }}</span>
            </div>
          </li>
          <li
            v-for="i in READS_PAGE_SIZE - pagedReads.length"
            :key="`empty-${i}`"
            class="reads-item reads-item-empty"
          />
        </ul>
        <SPager
          v-model="readsPage"
          :total="readsPages"
          class="mt-4"
        />
      </div>
      <KnowledgeGraph />
    </section>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch, defineAsyncComponent,
} from 'vue';
import {
  PhPackage, PhReadCvLogo, PhNewspaper,
} from '@phosphor-icons/vue';
import { useThoughtStore } from '@/stores/thoughts';
import { useJourneyStore } from '@/stores/journeys';
import { useBookStore } from '@/stores/books';
import { useBlogs } from '@/stores/blogs';
import { usePaperStore } from '@/stores/papers';
import SFilterBar from '@/components/common/SFilterBar.vue';
import SPager from '@/components/common/SPager.vue';

const KnowledgeGraph = defineAsyncComponent(() => import('@/components/KnowledgeGraph.vue'));

const { getRecent } = useThoughtStore();
const { journeys } = useJourneyStore();
const bookStore = useBookStore();
const blogStore = useBlogs();
const paperStore = usePaperStore();

const READS_PAGE_SIZE = 5;
const readsJourneys = ref<string[]>([]);
const readsTypes = ref<string[]>([]);
const readsPage = ref(1);

const readsStats = computed(() => {
  const js = readsJourneys.value;
  const books = js.length
    ? js.flatMap((j) => bookStore.getByJourney(j)).filter((b) => !b.parent)
    : bookStore.books.filter((b) => !b.parent);
  const blogs = js.length
    ? js.flatMap((j) => blogStore.getPosts(j))
    : blogStore.blogs.filter((b) => b.posts.length === 0);
  const papers = js.length
    ? js.flatMap((j) => paperStore.getByJourney(j))
    : paperStore.papers;

  const statsItems = [
    {
      label: 'books',
      type: 'book',
      count: books.length,
    },
    {
      label: 'posts',
      type: 'post',
      count: blogs.length,
    },
    {
      label: 'papers',
      type: 'paper',
      count: papers.length,
    },
  ];
  return statsItems;
});

const readsItems = computed(() => {
  const js = readsJourneys.value;
  const ts = readsTypes.value;

  const books = (js.length ? js.flatMap((j) => bookStore.getByJourney(j)) : bookStore.books)
    .filter((b) => !b.parent)
    .map((b) => ({
      slug: b.slug,
      type: 'book',
      title: b.title,
      url: '',
      meta: [b.author, b.date].filter(Boolean).join(' · '),
    }));

  const blogs = (js.length ? js.flatMap((j) => blogStore.getPosts(j)) : blogStore.blogs.filter((b) => b.posts.length === 0))
    .map((b) => ({
      slug: b.slug,
      type: 'post',
      title: b.title,
      url: b.url,
      meta: b.author,
    }));

  const papers = (js.length ? js.flatMap((j) => paperStore.getByJourney(j)) : paperStore.papers)
    .map((p) => ({
      slug: p.slug,
      type: 'paper',
      title: p.title,
      url: p.url,
      meta: [
        p.authors.join(', '),
        p.venue,
        p.year,
      ].filter(Boolean).join(' · '),
    }));

  const all = [
    ...books,
    ...blogs,
    ...papers,
  ];
  return ts.length ? all.filter((item) => ts.includes(item.type)) : all;
});

const readsPages = computed(() => Math.max(1, Math.ceil(readsItems.value.length / READS_PAGE_SIZE)));
const pagedReads = computed(() => {
  const start = (readsPage.value - 1) * READS_PAGE_SIZE;
  return readsItems.value.slice(start, start + READS_PAGE_SIZE);
});

watch([readsJourneys, readsTypes], () => {
  readsPage.value = 1;
}, { deep: true });

const filterGroups = computed(() => [
  journeys.map((j) => ({
    label: j.title,
    value: j.slug,
  })),
  readsStats.value.map((r) => ({
    label: `${r.count} ${r.label}`,
    value: r.type,
    colorClass: r.type,
  })),
]);

const filterValues = computed(() => [readsJourneys.value, readsTypes.value]);

function onFilterUpdate (values: string[][]) {
  readsJourneys.value = values[0];
  readsTypes.value = values[1];
}

const recentPosts = getRecent(5);

const projects = [
  {
    name: 'sqlingo.js',
    desc: 'A TypeScript mirror of sqlglot to run natively in the browser.',
    repo: 'https://github.com/huydo862003/sqlingo.js',
    docs: 'https://huydo862003.github.io/sqlingo.js/',
    npm: 'https://www.npmjs.com/package/@hdnax/sqlingo.js',
    status: 'alpha',
    tags: ['sql', 'incremental'],
  },
  {
    name: 'dboxide',
    desc: 'A rewrite of the DBML parser from past experience.',
    repo: 'https://github.com/huydo862003/dboxide',
    docs: 'https://huydo862003.github.io/dboxide',
    status: 'wip',
    tags: ['parser', 'rust'],
  },
  {
    name: 'splicer.js',
    desc: 'Design system and component library.',
    repo: 'https://github.com/huydo862003/RNA',
    docs: 'https://huydo862003.github.io/RNA/',
    npm: 'https://www.npmjs.com/package/@hdnax/splicer.js',
    status: 'wip',
    tags: ['design system'],
  },
  {
    name: 'MPiSC',
    desc: 'Porting shared-memory MPSCs to distributed context using MPI-3.',
    repo: 'https://github.com/huydo862003/MPiSC',
    docs: 'https://huydo862003.github.io/MPiSC/',
    status: 'done',
    tags: ['research', 'distributed'],
    links: [
      {
        label: 'dLTQueue (FDSE 2025)',
        url: 'https://www.researchgate.net/publication/395381301',
      },
      {
        label: 'Slotqueue (NPC 2025)',
        url: 'https://www.researchgate.net/publication/395448251',
      },
    ],
  },
  {
    name: 'type-theory',
    desc: 'Exercises and proofs from Software Foundations, TAPL, and PFPL.',
    repo: 'https://github.com/huydo862003/type-theory',
    status: 'active',
    tags: ['type theory', 'rocq'],
  },
];
</script>

<style scoped>
@reference "../style.css";
.main-section {
  min-height: calc(100vh - 3rem);
}
.hero h1 {
  @apply text-xl font-bold mb-1;
}
.hero p {
  @apply text-sm text-fg-muted max-w-lg mb-10;
}
.section {
  @apply mb-10;
}
.section h2 {
  @apply text-base font-bold mb-4 pb-2 border-b border-border;
}
.section-link {
  @apply no-underline hover:underline;
}
.list {
  @apply list-none p-0 m-0 flex flex-col gap-3;
}
.item {
  @apply border-l-2 border-fg-faint/30 pl-3 py-1;
}
.item-body {
  @apply flex flex-col;
}
.item-row {
  @apply flex flex-wrap gap-x-3 gap-y-0.5 items-baseline;
}
.date {
  @apply text-xs text-fg-faint shrink-0 tabular-nums;
}
.item-link {
  @apply text-sm font-medium;
}
.desc {
  @apply text-xs text-fg-faint mt-0.5;
}
.project-header {
  @apply flex flex-wrap items-center gap-1.5;
}
.project-tags {
  @apply flex flex-wrap gap-1 mt-1;
}
.cat-tag {
  @apply text-fg-faint border border-border rounded-sm px-1.5;
  font-size: 0.625rem;
  line-height: 1.25rem;
}
.project-links {
  @apply flex flex-wrap items-center gap-x-3 gap-y-0.5 mt-0.5;
}
.plink {
  @apply inline-flex items-center gap-1 text-xs text-fg-faint
         no-underline hover:text-accent-blue transition-colors;
}
.empty {
  @apply text-sm text-fg-faint;
}
.section-sep {
  @apply border-t border-border py-10;
}
.graph-section {
  @apply px-0;
}
.reads-panel {
  @apply max-w-2xl mx-auto px-4 py-8;
}
.reads-heading {
  @apply text-base font-bold mb-4 pb-2 border-b border-border;
}
.reads-list {
  @apply list-none p-0 m-0 flex flex-col;
}
.reads-item {
  @apply flex items-start gap-2 border-b border-border/50;
  height: 3.25rem;
  padding-top: 0.625rem;
}
.reads-item-empty {
  @apply border-b border-border/20;
  padding-top: 0;
}
.reads-item-body {
  @apply flex flex-col min-w-0 flex-1;
}
.reads-item-title {
  @apply text-xs text-fg-muted no-underline hover:text-accent-blue transition-colors truncate;
  line-height: 1.2rem;
  margin-bottom: 0.2rem;
}
.reads-item-title.no-link {
  @apply cursor-default hover:text-fg-muted;
}
.reads-item-meta {
  @apply text-fg-faint truncate;
  font-size: 0.625rem;
  line-height: 1rem;
}
.reads-type {
  @apply shrink-0 px-1.5 rounded-sm;
  font-size: 0.625rem;
  line-height: 1.2rem;
}
.reads-type-book {
  @apply bg-accent-blue/10 text-accent-blue;
}
.reads-type-post {
  @apply bg-accent-green/10 text-accent-green;
}
.reads-type-paper {
  @apply bg-accent-yellow/10 text-accent-yellow;
}
.reads-empty {
  @apply text-xs text-fg-faint;
}
</style>
