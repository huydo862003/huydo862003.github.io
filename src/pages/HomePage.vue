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
            <router-link
              :to="`/journeys/${j.slug}`"
              class="item-body item-body-link"
            >
              <div class="item-row">
                <span class="item-link">{{ j.title }}</span>
                <span :class="`status-${j.status}`">{{ j.status }}</span>
              </div>
              <span
                v-if="j.description"
                class="desc"
              >{{ j.description }}</span>
            </router-link>
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
            <a
              :href="p.repo"
              target="_blank"
              rel="noopener"
              class="item-body item-body-link"
            >
              <div class="project-header">
                <span
                  v-tooltip="{ content: p.repo, placement: 'bottom' }"
                  class="item-link"
                >
                  <PhArrowSquareOut :size="11" class="ext-icon" />{{ p.name }}
                </span>
                <span :class="`status-${p.status}`">{{ p.status }}</span>
              </div>
              <div
                v-if="p.npm || p.docs"
                class="project-links"
                @click.stop
              >
                <a
                  v-if="p.npm"
                  v-tooltip="{ content: p.npm, placement: 'bottom' }"
                  :href="p.npm"
                  target="_blank"
                  rel="noopener"
                  class="plink"
                >
                  <PhPackage :size="12" /> npm
                </a>
                <a
                  v-if="p.docs"
                  v-tooltip="{ content: p.docs, placement: 'bottom' }"
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
                @click.stop
              >
                <a
                  v-for="l in p.links"
                  :key="l.url"
                  v-tooltip="{ content: l.url, placement: 'bottom' }"
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
            </a>
          </li>
        </ul>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import {
  PhPackage, PhReadCvLogo, PhNewspaper, PhArrowSquareOut,
} from '@phosphor-icons/vue';
import { useSeo } from '@/composables/useSeo';
import { useThoughtStore } from '@/stores/thoughts';
import { useJourneyStore } from '@/stores/journeys';

useSeo({
  title: ref(undefined),
  description: ref('Scrambled thoughts, journeys, and reads on programming language theory, design, and computer science.'),
  path: ref('/'),
  type: 'website',
});

const { getRecent } = useThoughtStore();
const { journeys } = useJourneyStore();

const recentPosts = getRecent(5);

const projects = [
  {
    name: 'sqlingo.js',
    desc: 'A TypeScript mirror of sqlglot to run natively in the browser.',
    repo: 'https://github.com/huydo862003/sqlingo.js',
    docs: 'https://huydo862003.github.io/sqlingo.js/',
    npm: 'https://www.npmjs.com/package/@hdnax/sqlingo.js',
    status: 'alpha',
    tags: ['sql'],
  },
  {
    name: 'dboxide',
    desc: 'A rewrite of the DBML parser from past experience.',
    repo: 'https://github.com/huydo862003/dboxide',
    docs: 'https://huydo862003.github.io/dboxide',
    status: 'researching',
    tags: ['parser', 'rust'],
  },
  {
    name: 'splicer.js',
    desc: 'Design system and component library.',
    repo: 'https://github.com/huydo862003/RNA',
    docs: 'https://huydo862003.github.io/RNA/',
    npm: 'https://www.npmjs.com/package/@hdnax/splicer.js',
    status: 'researching',
    tags: ['incremental'],
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
  @apply border-l-2 border-fg-faint/30 pl-3 py-1 rounded-sm transition-colors;
}
.item:has(.item-body-link:hover) {
  @apply bg-bg-subtle border-accent-blue/50;
}
.item-body {
  @apply flex flex-col;
}
.item-body-link {
  @apply no-underline cursor-pointer;
}
.item-body-link:hover .item-link {
  @apply text-accent-blue;
}
.ext-icon {
  @apply inline-block mr-1 opacity-50 shrink-0;
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
</style>
