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
        <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: journey?.title ?? slug, to: `/journeys/${slug}` }]" />
      </div>
      <div class="flex flex-wrap items-center gap-x-3 gap-y-1 mb-6">
        <h1 class="text-xl font-bold">
          {{ journey.title }}
        </h1>
        <span :class="`status-${journey.status}`">{{ journey.status }}</span>
      </div>

      <div class="grid grid-cols-2 sm:grid-cols-3 gap-3 sm:gap-4 mb-6">
        <router-link
          v-for="s in statCards"
          :key="s.label"
          :to="s.to"
          class="grid justify-items-center sm:justify-items-start border border-border rounded-sm
                 py-2.5 px-3 sm:py-4 sm:px-4 text-center sm:text-left no-underline cursor-pointer
                 hover:border-fg-faint hover:bg-bg-subtle/50 transition-colors"
        >
          <div class="relative w-8 h-8 sm:w-16 sm:h-16 shrink-0">
            <div
              class="absolute inset-0 rounded-full"
              style="mask: radial-gradient(farthest-side, transparent 65%, #000 67%); -webkit-mask: radial-gradient(farthest-side, transparent 65%, #000 67%);"
              :style="ringStyle(s)"
            />
          </div>
          <div class="flex flex-col">
            <span class="text-xs sm:text-sm font-semibold text-fg">{{ s.count }} {{ s.label }}</span>
            <div class="hidden sm:flex flex-col gap-0.5 mt-0.5">
              <span
                v-for="line in s.lines"
                :key="line.label"
                class="text-xs"
                :class="{
                  'text-accent-green': line.color === 'green',
                  'text-accent-yellow': line.color === 'yellow',
                  'text-accent-red': line.color === 'red',
                  'text-fg-faint': line.color === 'muted',
                }"
              >{{ line.value }} {{ line.label }}</span>
            </div>
          </div>
        </router-link>
      </div>

      <nav class="flex flex-col gap-1 mb-8">
        <router-link
          v-for="r in resources"
          :key="r.to"
          :to="r.to"
          class="flex items-center gap-2 px-3 py-2 rounded-sm no-underline text-fg-muted hover:bg-bg-subtle transition-colors"
        >
          <GIcon
            :name="r.icon"
            :size="16"
            class="text-fg-faint"
          />
          <span class="text-sm">{{ r.label }}</span>
          <span class="text-xs text-fg-faint ml-auto">{{ r.count }}</span>
        </router-link>
      </nav>

      <div
        v-if="content"
        class="prose"
        v-html="content"
      />
      <p
        v-else
        class="text-fg-faint text-sm"
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
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useJourneyStore,
} from '@/stores/journeys';
import {
  usePhaseStore,
} from '@/stores/phases';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useFlashcardStore,
} from '@/stores/flashcards';
import {
  useBookStore,
} from '@/stores/books';
import {
  useBlogs,
} from '@/stores/blogs';
import {
  usePaperStore,
} from '@/stores/papers';
import {
  loadContent,
} from '@/utils/content';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const journeyStore = useJourneyStore();
const {
  getBySlug,
} = journeyStore;
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
} = useAsyncState(
  async () => journey.value ? loadContent(journey.value.slug) : '',
  '',
);
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

function ringStyle (s: {
  segments: {
    pct: number;
    color: string;
  }[];
}) {
  const parts: string[] = [];
  let acc = 0;
  for (const seg of s.segments) {
    parts.push(`${seg.color} ${acc}% ${acc + seg.pct}%`);
    acc += seg.pct;
  }
  parts.push(`var(--color-bg-subtle) ${acc}% 100%`);
  return {
    background: `conic-gradient(${parts.join(', ')})`,
  };
}

const reviewedToday = computed(() => {
  const cards = flashcardStore.getByJourney(journeyConceptSlugs.value);
  const today = new Date()
    .toISOString()
    .slice(0, 10);
  return cards.filter((c) => {
    const cardState = flashcardStore.getState(c.slug);
    return cardState.lastReviewedAt === today;
  }).length;
});

const statCards = computed(() => {
  const journeySlug = slug.value;
  const cs = conceptStats.value;
  const fs = flashcardStats.value;
  const ps = phaseStats.value;
  const reviewed = reviewedToday.value;

  function pct (numerator: number, total: number) {
    return total ? Math.round((numerator / total) * 100) : 0;
  }

  return [
    {
      label: 'concepts',
      count: cs.total,
      to: `/journeys/${journeySlug}/concepts`,
      segments: [
        {
          pct: pct(cs.mastered, cs.total),
          color: 'var(--color-accent-green)',
        },
        {
          pct: pct(cs.reviewing, cs.total),
          color: 'var(--color-accent-yellow)',
        },
      ],
      lines: [
        {
          value: cs.mastered,
          label: `mastered (${pct(cs.mastered, cs.total)}%)`,
          color: 'green',
        },
        {
          value: cs.reviewing,
          label: `reviewing (${pct(cs.reviewing, cs.total)}%)`,
          color: 'yellow',
        },
        {
          value: cs.learning,
          label: `learning (${pct(cs.learning, cs.total)}%)`,
          color: 'muted',
        },
      ],
    },
    {
      label: 'flashcards',
      count: fs.total,
      to: `/journeys/${journeySlug}/flashcards`,
      segments: [
        {
          pct: pct(reviewed, fs.dueToday || 1),
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
      to: `/journeys/${journeySlug}/phases`,
      segments: [
        {
          pct: pct(ps.completed, ps.total),
          color: 'var(--color-accent-green)',
        },
        {
          pct: pct(ps.active, ps.total),
          color: 'var(--color-accent-yellow)',
        },
      ],
      lines: [
        {
          value: ps.active,
          label: `active (${pct(ps.active, ps.total)}%)`,
          color: 'yellow',
        },
        {
          value: ps.completed,
          label: `completed (${pct(ps.completed, ps.total)}%)`,
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
  const currentSlug = slug.value;
  const ps = phaseStats.value;
  const books = bookStore.getByJourney(currentSlug);
  const blogs = blogStore.getByJourney(currentSlug);
  const papers = paperStore.getByJourney(currentSlug);
  return [
    {
      label: 'Phases',
      count: ps.total,
      to: `/journeys/${currentSlug}/phases`,
      icon: GIconName.Flag,
    },
    {
      label: 'Concepts',
      count: conceptStats.value.total,
      to: `/journeys/${currentSlug}/concepts`,
      icon: GIconName.Brain,
    },
    {
      label: 'Flashcards',
      count: flashcardStats.value.total,
      to: `/journeys/${currentSlug}/flashcards`,
      icon: GIconName.Cards,
    },
    {
      label: 'Books',
      count: books.length,
      to: `/journeys/${currentSlug}/books`,
      icon: GIconName.Book,
    },
    {
      label: 'Blogs',
      count: blogs.length,
      to: `/journeys/${currentSlug}/blogs`,
      icon: GIconName.Rss,
    },
    {
      label: 'Papers',
      count: papers.length,
      to: `/journeys/${currentSlug}/papers`,
      icon: GIconName.Newspaper,
    },
  ].filter((r) => 0 < r.count);
});
</script>
