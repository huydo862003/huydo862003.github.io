<template>
  <div>
    <section class="page home-section">
      <div>
        <h1 class="text-xl font-bold mb-1">
          Scrambled Kitchen
        </h1>
        <p class="home-desc text-sm max-w-lg mb-10">
          Scrambled thoughts. Scrambled journeys. And scrambled eggs.

          Just batch migrated from Notion for easier customization & decentralized backups, so things may currently be scrambled up a bit.
        </p>
      </div>

      <div class="mb-10">
        <h2 class="home-section-heading text-base font-bold mb-4 pb-2 border-b">
          <RouterLink
            to="/thoughts"
            class="no-underline hover:underline"
          >
            Scrambled Thoughts
          </RouterLink>
        </h2>
        <ul
          v-if="recentPosts.length"
          class="list-none p-0 m-0 flex flex-col gap-3"
        >
          <li
            v-for="post in recentPosts"
            :key="post.slug"
            class="item border-l-2 pl-3 py-1 rounded-sm transition-colors"
          >
            <div class="flex flex-col">
              <div class="flex flex-wrap gap-x-3 gap-y-0.5 items-baseline">
                <span class="item-date text-xs shrink-0 tabular-nums">{{ post.date }}</span>
                <RouterLink
                  :to="`/thoughts/${post.slug}`"
                  class="item-link text-sm font-medium"
                >
                  {{ post.title }}
                </RouterLink>
              </div>
              <span
                v-if="post.description"
                class="item-desc text-xs mt-0.5"
              >{{ post.description }}</span>
            </div>
          </li>
        </ul>
        <p
          v-else
          class="home-empty text-sm"
        >
          No thoughts yet. Still scrambling.
        </p>
      </div>

      <div class="mb-10">
        <h2 class="home-section-heading text-base font-bold mb-4 pb-2 border-b">
          <RouterLink
            to="/journeys"
            class="no-underline hover:underline"
          >
            Scrambled Journeys
          </RouterLink>
        </h2>
        <ul
          v-if="journeys.length"
          class="list-none p-0 m-0 flex flex-col gap-3"
        >
          <li
            v-for="journey in journeys"
            :key="journey.slug"
            class="item border-l-2 pl-3 py-1 rounded-sm transition-colors"
          >
            <RouterLink
              :to="`/journeys/${journey.slug}`"
              class="item-body-link flex flex-col no-underline cursor-pointer"
            >
              <div class="flex flex-wrap gap-x-3 gap-y-0.5 items-baseline">
                <span class="item-link text-sm font-medium">{{ journey.title }}</span>
                <span :class="`status-${journey.status}`">{{ journey.status }}</span>
              </div>
              <span
                v-if="journey.description"
                class="item-desc text-xs mt-0.5"
              >{{ journey.description }}</span>
            </RouterLink>
          </li>
        </ul>
        <p
          v-else
          class="home-empty text-sm"
        >
          No journeys yet. Still scrambling with the baggage.
        </p>
      </div>
      <div class="mb-10">
        <h2 class="home-section-heading text-base font-bold mb-4 pb-2 border-b">
          Scrambled Projects &amp; Research
        </h2>
        <ul class="list-none p-0 m-0 flex flex-col gap-3">
          <li
            v-for="project in projects"
            :key="project.name"
            class="item border-l-2 pl-3 py-1 rounded-sm transition-colors"
          >
            <a
              :href="project.repo"
              target="_blank"
              rel="noopener noreferrer"
              class="item-body-link flex flex-col no-underline cursor-pointer"
            >
              <div class="flex flex-wrap items-center gap-1.5">
                <span
                  v-tooltip="{
                    content: project.repo,
                    placement: 'bottom',
                  }"
                  class="item-link text-sm font-medium"
                >
                  <GIcon
                    :name="GIconName.ExternalLink"
                    :size="11"
                    class="inline-block mr-1 opacity-50 shrink-0"
                  />{{ project.name }}
                </span>
                <span :class="`status-${project.status}`">{{ project.status }}</span>
              </div>
              <div
                v-if="project.npm || project.docs"
                class="flex flex-wrap items-center gap-x-3 gap-y-0.5 mt-0.5"
                @click.stop
              >
                <a
                  v-if="project.npm"
                  v-tooltip="{
                    content: project.npm,
                    placement: 'bottom',
                  }"
                  :href="project.npm"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="plink inline-flex items-center gap-1 text-xs no-underline transition-colors py-1"
                >
                  <GIcon
                    :name="GIconName.Package"
                    :size="12"
                  /> npm
                </a>
                <a
                  v-if="project.docs"
                  v-tooltip="{
                    content: project.docs,
                    placement: 'bottom',
                  }"
                  :href="project.docs"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="plink inline-flex items-center gap-1 text-xs no-underline transition-colors py-1"
                >
                  <GIcon
                    :name="GIconName.ReadCvLogo"
                    :size="12"
                  /> docs
                </a>
              </div>
              <span class="item-desc text-xs mt-0.5">{{ project.desc }}</span>
              <div
                v-if="project.links?.length"
                class="flex flex-wrap items-center gap-x-3 gap-y-0.5 mt-0.5"
                @click.stop
              >
                <a
                  v-for="link in project.links"
                  :key="link.url"
                  v-tooltip="{
                    content: link.url,
                    placement: 'bottom',
                  }"
                  :href="link.url"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="plink inline-flex items-center gap-1 text-xs no-underline transition-colors py-1"
                >
                  <GIcon
                    :name="GIconName.Newspaper"
                    :size="12"
                  /> {{ link.label }}
                </a>
              </div>
              <div class="flex flex-wrap gap-1 mt-1">
                <span
                  v-for="tag in project.tags"
                  :key="tag"
                  class="project-tag border rounded-sm px-1.5"
                >{{ tag }}</span>
              </div>
            </a>
          </li>
        </ul>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import {
  ref,
} from 'vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useThoughtStore,
} from '@/stores/thoughts';
import {
  useJourneyStore,
} from '@/stores/journeys';

useSeo({
  title: ref<string | undefined>(undefined),
  description: ref('Scrambled thoughts, journeys, and reads on programming language theory, design, and computer science.'),
  path: ref('/'),
  type: 'website',
});

const {
  getRecent,
} = useThoughtStore();
const {
  journeys,
} = useJourneyStore();

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
    tags: [
      'parser',
      'rust',
    ],
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
    tags: [
      'research',
      'distributed',
    ],
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
    tags: [
      'type theory',
      'rocq',
    ],
  },
];
</script>

<style scoped>
.home-section {
  min-height: calc(100vh - 3rem);
}
.home-desc {
  color: var(--gui-neutral-fg-muted);
}
.home-section-heading {
  border-color: var(--gui-neutral-border);
}
.item {
  border-color: color-mix(in oklch, var(--gui-neutral-solid) 30%, transparent);
}
.item-date {
  color: var(--gui-neutral-solid);
}
.item-desc {
  color: var(--gui-neutral-fg-muted);
}
.home-empty {
  color: var(--gui-neutral-fg-muted);
}
.plink {
  color: var(--gui-neutral-fg-muted);
}
.project-tag {
  color: var(--gui-neutral-fg-muted);
  border-color: var(--gui-neutral-border);
  font-size: 0.625rem;
  line-height: 1.25rem;
}
.item:has(.item-body-link:hover) {
  background-color: var(--gui-neutral-bg-subtle);
  border-color: color-mix(in oklch, var(--gui-info-solid) 50%, transparent);
}
.item-body-link:hover .item-link {
  color: var(--gui-info-solid);
}
.plink:hover { color: var(--gui-info-solid); }
</style>
