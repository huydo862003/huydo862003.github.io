<template>
  <div class="page">
    <template v-if="journey">
      <div class="top-bar">
        <router-link
          to="/journeys"
          class="back"
        >
          &larr; all journeys
        </router-link>
        <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: journey?.title ?? slug, to: `/journeys/${slug}` }]" />
      </div>
      <div class="title-row">
        <h1>{{ journey.title }}</h1>
        <span :class="`status-${journey.status}`">{{ journey.status }}</span>
      </div>

      <div class="stats-row">
        <router-link
          v-for="s in statCards"
          :key="s.label"
          :to="s.to"
          class="stat-card"
        >
          <div class="ring-wrap">
            <div
              class="ring"
              :style="ringStyle(s)"
            />
          </div>
          <div class="stat-body">
            <span class="stat-title">{{ s.count }} {{ s.label }}</span>
            <div class="stat-lines">
              <span
                v-for="line in s.lines"
                :key="line.label"
                :class="['stat-line', line.color]"
              >{{ line.value }} {{ line.label }}</span>
            </div>
          </div>
        </router-link>
      </div>

      <nav class="resource-list">
        <router-link
          v-for="r in resources"
          :key="r.to"
          :to="r.to"
          class="resource"
        >
          <component
            :is="r.icon"
            :size="16"
            class="resource-icon"
          />
          <span class="resource-label">{{ r.label }}</span>
          <span class="resource-count">{{ r.count }}</span>
        </router-link>
      </nav>

      <div
        v-if="content"
        class="prose"
        v-html="content"
      />
      <p
        v-else
        class="empty"
      >
        No content yet.
      </p>

      <ResourcePagination
        kind="journey"
        :prev="prevJourney"
        :next="nextJourney"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link to="/journeys">
          Back to journeys
        </router-link>
      </p>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  computed, watch, defineAsyncComponent,
} from 'vue';
import { useAsyncState } from '@vueuse/core';
import { useRoute } from 'vue-router';
import {
  PhFlag, PhBrain, PhCards, PhBook, PhRss, PhNewspaper,
} from '@phosphor-icons/vue';
import { useSeo } from '@/composables/useSeo';
import { useJourneyStore } from '@/stores/journeys';
import { usePhaseStore } from '@/stores/phases';
import { useConceptStore } from '@/stores/concepts';
import { useFlashcardStore } from '@/stores/flashcards';
import { useBookStore } from '@/stores/books';
import { useBlogs } from '@/stores/blogs';
import { usePaperStore } from '@/stores/papers';
import { loadContent } from '@/utils/content';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const journeyStore = useJourneyStore();
const { getBySlug } = journeyStore;
const phaseStore = usePhaseStore();
const conceptStore = useConceptStore();
const flashcardStore = useFlashcardStore();
const bookStore = useBookStore();
const blogStore = useBlogs();
const paperStore = usePaperStore();

const slug = computed(() => route.params.slug as string);
const journey = computed(() => getBySlug(slug.value));

useSeo({
  title: computed(() => journey.value?.title),
  description: computed(() => journey.value?.description),
  path: computed(() => `/journeys/${slug.value}`),
});

const currentIdx = computed(() => journeyStore.journeys.findIndex((j) => j.slug === slug.value));
const prevJourney = computed(() => {
  const j = journeyStore.journeys[currentIdx.value - 1];
  return j && {
    to: `/journeys/${j.slug}`,
    title: j.title,
  };
});
const nextJourney = computed(() => {
  const j = journeyStore.journeys[currentIdx.value + 1];
  return j && {
    to: `/journeys/${j.slug}`,
    title: j.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => journey.value ? loadContent(journey.value.slug) : '', '');
watch(journey, () => reloadContent());

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));
const journeyConceptSlugs = computed(() => journeyConcepts.value.map((c) => c.slug));

const conceptStats = computed(() => conceptStore.statsByJourney(slug.value));

const flashcardStats = computed(() => {
  const cards = flashcardStore.getByJourney(journeyConceptSlugs.value);
  return flashcardStore.statsForCards(cards);
});

const phaseStats = computed(() => {
  const phases = phaseStore.getByJourney(slug.value);
  return {
    total: phases.length,
    active: phases.filter((p) => p.status === 'active').length,
    completed: phases.filter((p) => p.status === 'completed').length,
    onHold: phases.filter((p) => p.status === 'on-hold').length,
  };
});

function ringStyle (s: { segments: { pct: number;
  color: string; }[]; }) {
  const parts: string[] = [];
  let acc = 0;
  for (const seg of s.segments) {
    parts.push(`${seg.color} ${acc}% ${acc + seg.pct}%`);
    acc += seg.pct;
  }
  parts.push(`var(--color-bg-subtle) ${acc}% 100%`);
  return { background: `conic-gradient(${parts.join(', ')})` };
}

const reviewedToday = computed(() => {
  const cards = flashcardStore.getByJourney(journeyConceptSlugs.value);
  const today = new Date().toISOString()
    .slice(0, 10);
  return cards.filter((c) => {
    const s = flashcardStore.getState(c.slug);
    return s.lastReviewedAt === today;
  }).length;
});

const statCards = computed(() => {
  const j = slug.value;
  const cs = conceptStats.value;
  const fs = flashcardStats.value;
  const ps = phaseStats.value;
  const reviewed = reviewedToday.value;

  function p (n: number, t: number) {
    return t ? Math.round((n / t) * 100) : 0;
  }

  return [
    {
      label: 'concepts',
      count: cs.total,
      to: `/journeys/${j}/concepts`,
      segments: [
        {
          pct: p(cs.mastered, cs.total),
          color: 'var(--color-accent-green)',
        },
        {
          pct: p(cs.reviewing, cs.total),
          color: 'var(--color-accent-yellow)',
        },
      ],
      lines: [
        {
          value: cs.mastered,
          label: `mastered (${p(cs.mastered, cs.total)}%)`,
          color: 'green',
        },
        {
          value: cs.reviewing,
          label: `reviewing (${p(cs.reviewing, cs.total)}%)`,
          color: 'yellow',
        },
        {
          value: cs.learning,
          label: `learning (${p(cs.learning, cs.total)}%)`,
          color: 'muted',
        },
      ],
    },
    {
      label: 'flashcards',
      count: fs.total,
      to: `/journeys/${j}/flashcards`,
      segments: [
        {
          pct: p(reviewed, fs.dueToday || 1),
          color: 'var(--color-accent-green)',
        },
      ],
      lines: [
        {
          value: reviewed,
          label: 'reviewed today',
          color: 'green',
        },
        {
          value: fs.dueToday,
          label: 'due today',
          color: 'red',
        },
        {
          value: fs.mastered,
          label: 'mastered',
          color: 'muted',
        },
      ],
    },
    {
      label: 'phases',
      count: ps.total,
      to: `/journeys/${j}/phases`,
      segments: [
        {
          pct: p(ps.completed, ps.total),
          color: 'var(--color-accent-green)',
        },
        {
          pct: p(ps.active, ps.total),
          color: 'var(--color-accent-yellow)',
        },
      ],
      lines: [
        {
          value: ps.active,
          label: `active (${p(ps.active, ps.total)}%)`,
          color: 'yellow',
        },
        {
          value: ps.completed,
          label: `completed (${p(ps.completed, ps.total)}%)`,
          color: 'green',
        },
        {
          value: ps.onHold,
          label: 'on hold',
          color: 'muted',
        },
      ],
    },
  ].filter((c) => 0 < c.count);
});

const resources = computed(() => {
  const s = slug.value;
  const ps = phaseStats.value;
  const books = bookStore.getByJourney(s);
  const blogs = blogStore.getByJourney(s);
  const papers = paperStore.getByJourney(s);
  return [
    {
      label: 'Phases',
      count: ps.total,
      to: `/journeys/${s}/phases`,
      icon: PhFlag,
    },
    {
      label: 'Concepts',
      count: conceptStats.value.total,
      to: `/journeys/${s}/concepts`,
      icon: PhBrain,
    },
    {
      label: 'Flashcards',
      count: flashcardStats.value.total,
      to: `/journeys/${s}/flashcards`,
      icon: PhCards,
    },
    {
      label: 'Books',
      count: books.length,
      to: `/journeys/${s}/books`,
      icon: PhBook,
    },
    {
      label: 'Blogs',
      count: blogs.length,
      to: `/journeys/${s}/blogs`,
      icon: PhRss,
    },
    {
      label: 'Papers',
      count: papers.length,
      to: `/journeys/${s}/papers`,
      icon: PhNewspaper,
    },
  ].filter((r) => 0 < r.count);
});
</script>

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold;
}
.title-row {
  @apply flex flex-wrap items-center gap-x-3 gap-y-1 mb-6;
}
.stats-row {
  @apply grid grid-cols-2 sm:grid-cols-3 gap-3 sm:gap-4 mb-6;
}
.stat-card {
  @apply grid justify-items-center sm:justify-items-start border border-border rounded-sm
         py-2.5 px-3 sm:py-4 sm:px-4 text-center sm:text-left
         no-underline cursor-pointer hover:border-fg-faint hover:bg-bg-subtle/50 transition-colors;
}
.ring-wrap {
  @apply relative w-8 h-8 sm:w-16 sm:h-16 shrink-0;
}
.ring {
  @apply absolute inset-0 rounded-full;
  mask: radial-gradient(farthest-side, transparent 65%, #000 67%);
  -webkit-mask: radial-gradient(farthest-side, transparent 65%, #000 67%);
}
.stat-body {
  @apply flex flex-col;
}
.stat-title {
  @apply text-xs sm:text-sm font-semibold text-fg;
}
.stat-lines {
  @apply hidden sm:flex flex-col gap-0.5 mt-0.5;
}
.stat-line {
  @apply text-xs;
}
.stat-line.green {
  @apply text-accent-green;
}
.stat-line.yellow {
  @apply text-accent-yellow;
}
.stat-line.red {
  @apply text-accent-red;
}
.stat-line.muted {
  @apply text-fg-faint;
}
.resource-list {
  @apply flex flex-col gap-1 mb-8;
}
.resource {
  @apply flex items-center gap-2 px-3 py-2 rounded-sm no-underline
         text-fg-muted hover:bg-bg-subtle transition-colors;
}
.resource-icon {
  @apply text-fg-faint;
}
.resource-label {
  @apply text-sm;
}
.resource-count {
  @apply text-xs text-fg-faint ml-auto;
}
</style>
