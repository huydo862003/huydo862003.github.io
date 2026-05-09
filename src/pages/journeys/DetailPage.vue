<template>
  <div class="page">
    <template v-if="journey">
      <div class="top-bar">
        <RouterLink
          to="/journeys"
          class="back"
        >
          &larr; all journeys
        </RouterLink>
        <JourneyBreadcrumb
          :crumbs="[
            {
              label: 'Journeys',
              to: '/journeys',
            },
            {
              label: journey?.title ?? slug,
              to: `/journeys/${slug}`,
            },
          ]"
        />
      </div>
      <div class="flex flex-wrap items-center gap-x-3 gap-y-1 mb-6">
        <h1 class="text-xl font-bold">
          {{ journey.title }}
        </h1>
        <span :class="`status-${journey.status}`">{{ journey.status }}</span>
      </div>

      <div class="grid grid-cols-2 sm:grid-cols-3 gap-3 sm:gap-4 mb-6">
        <RouterLink
          v-for="s in statCards"
          :key="s.label"
          :to="s.to"
          class="journey-stat-card grid justify-items-center sm:justify-items-start border rounded-sm
                 py-2.5 px-3 sm:py-4 sm:px-4 text-center sm:text-left no-underline cursor-pointer
                 transition-colors"
        >
          <div class="relative w-8 h-8 sm:w-16 sm:h-16 shrink-0">
            <div
              class="stat-ring absolute inset-0 rounded-full"
              :style="ringStyle(s)"
            />
          </div>
          <div class="flex flex-col">
            <span class="stat-count text-xs sm:text-sm font-semibold">{{ s.count }} {{ s.label }}</span>
            <div class="hidden sm:flex flex-col gap-0.5 mt-0.5">
              <span
                v-for="line in s.lines"
                :key="line.label"
                class="text-xs"
                :style="{
                  color: line.color === 'green'
                    ? 'var(--gui-success-solid)'
                    : line.color === 'yellow'
                      ? 'var(--gui-warning-solid)'
                      : line.color === 'red'
                        ? 'var(--gui-danger-solid)'
                        : 'var(--gui-neutral-solid)',
                }"
              >{{ line.value }} {{ line.label }}</span>
            </div>
          </div>
        </RouterLink>
      </div>

      <nav class="flex flex-col gap-1 mb-8">
        <RouterLink
          v-for="r in resources"
          :key="r.to"
          :to="r.to"
          class="journey-resource-link flex items-center gap-2 px-3 py-2 rounded-sm no-underline transition-colors"
        >
          <GIcon
            :name="r.icon"
            :size="16"
            class="resource-icon"
          />
          <span class="text-sm">{{ r.label }}</span>
          <span class="resource-count text-xs ml-auto">{{ r.count }}</span>
        </RouterLink>
      </nav>

      <div
        v-if="content"
        class="prose"
        v-html="content"
      />
      <p
        v-else
        class="content-empty text-sm"
      >
        No content yet.
      </p>

      <ResourcePagination
        kind="journey"
        :prev="previousJourney"
        :next="nextJourney"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <RouterLink to="/journeys">
          Back to journeys
        </RouterLink>
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
  useBlogStore,
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
const blogStore = useBlogStore();
const paperStore = usePaperStore();

const slug = computed(() => route.params.slug as string);
const journey = computed(() => getBySlug(slug.value));

useSeo({
  title: computed(() => journey.value?.title),
  description: computed(() => journey.value?.description),
  path: computed(() => `/journeys/${slug.value}`),
});

const currentIndex = computed(() => journeyStore.journeys.findIndex((index) => index.slug === slug.value));
const previousJourney = computed(() => {
  const index = journeyStore.journeys[currentIndex.value - 1];

  return index && {
    to: `/journeys/${index.slug}`,
    title: index.title,
  };
});
const nextJourney = computed(() => {
  const index = journeyStore.journeys[currentIndex.value + 1];

  return index && {
    to: `/journeys/${index.slug}`,
    title: index.title,
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
const journeyConceptSlugs = computed(() => journeyConcepts.value.map((concept) => concept.slug));
const conceptStats = computed(() => conceptStore.statsByJourney(slug.value));

const flashcardStats = computed(() => {
  const cards = flashcardStore.getByJourney(journeyConceptSlugs.value);

  return flashcardStore.statsForCards(cards);
});

const phaseStats = computed(() => {
  const phases = phaseStore.getByJourney(slug.value);

  return {
    total: phases.length,
    active: phases.filter((phase) => phase.status === 'active').length,
    completed: phases.filter((phase) => phase.status === 'completed').length,
    onHold: phases.filter((phase) => phase.status === 'on-hold').length,
  };
});

function ringStyle (stat: {
  segments: {
    pct: number;
    color: string;
  }[];
}) {
  const parts: string[] = [];
  let accumulator = 0;

  for (const segment of stat.segments) {
    parts.push(`${segment.color} ${accumulator}% ${accumulator + segment.pct}%`);
    accumulator += segment.pct;
  }
  parts.push(`var(--gui-neutral-bg-subtle) ${accumulator}% 100%`);

  return {
    background: `conic-gradient(${parts.join(', ')})`,
  };
}

const reviewedToday = computed(() => {
  const cards = flashcardStore.getByJourney(journeyConceptSlugs.value);
  const today = new Date()
    .toISOString()
    .slice(0, 10);

  return cards.filter((card) => {
    const cardState = flashcardStore.getState(card.slug);

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
          color: 'var(--gui-success-solid)',
        },
        {
          pct: pct(cs.reviewing, cs.total),
          color: 'var(--gui-warning-solid)',
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
          color: 'var(--gui-success-solid)',
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
          color: 'var(--gui-success-solid)',
        },
        {
          pct: pct(ps.active, ps.total),
          color: 'var(--gui-warning-solid)',
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
  ].filter((card) => 0 < card.count);
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
  ].filter((resource) => 0 < resource.count);
});
</script>

<style scoped>
.journey-stat-card {
  border-color: var(--gui-neutral-border);
}
.stat-ring {
  mask: radial-gradient(farthest-side, transparent 65%, #000 67%);
  -webkit-mask: radial-gradient(farthest-side, transparent 65%, #000 67%);
}
.stat-count {
  color: var(--gui-neutral-fg);
}
.journey-resource-link {
  color: var(--gui-neutral-fg-muted);
}
.resource-icon {
  color: var(--gui-neutral-solid);
}
.resource-count {
  color: var(--gui-neutral-solid);
}
.journey-stat-card:hover {
  border-color: var(--gui-neutral-solid);
  background-color: color-mix(in oklch, var(--gui-neutral-bg-subtle) 50%, transparent);
}
.journey-resource-link:hover { background-color: var(--gui-neutral-bg-subtle); }
</style>
