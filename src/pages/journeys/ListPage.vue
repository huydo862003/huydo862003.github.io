<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        to="/"
        class="back"
      >
        &larr; home
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }]" />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Scrambled Journeys
    </h1>

    <div
      v-if="journeys.length"
      class="flex flex-col gap-2"
    >
      <router-link
        v-for="j in journeys"
        :key="j.slug"
        :to="`/journeys/${j.slug}`"
        class="journey-card block border rounded-sm px-3 py-2.5 sm:px-4 sm:py-3 no-underline transition-colors"
      >
        <div class="flex flex-wrap items-center justify-between gap-1">
          <span class="journey-card-title text-sm font-semibold">{{ j.title }}</span>
          <span :class="`card-status status-${j.status}`">{{ j.status }}</span>
        </div>
        <div class="journey-card-stats flex flex-wrap gap-x-3 gap-y-0.5 mt-1 text-xs">
          <span>{{ plural(getConceptStats(j.slug).total, 'concept') }}</span>
          <span>{{ plural(getFlashcardCount(j.slug), 'flashcard') }}</span>
          <span>{{ plural(getPhaseCount(j.slug), 'phase') }}</span>
        </div>
      </router-link>
    </div>

    <p
      v-else
      class="journeys-empty text-sm"
    >
      No journeys yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  ref,
} from 'vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useJourneyStore,
} from '@/stores/journeys';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useFlashcardStore,
} from '@/stores/flashcards';
import {
  usePhaseStore,
} from '@/stores/phases';
import {
  plural,
} from '@/utils/format';

useSeo({
  title: ref('Scrambled Journeys'),
  description: ref('Learning journeys covering programming language theory, design, and computer science.'),
  path: ref('/journeys'),
  type: 'website',
});

const {
  journeys,
} = useJourneyStore();
const conceptStore = useConceptStore();
const flashcardStore = useFlashcardStore();
const phaseStore = usePhaseStore();

function getConceptStats (journeySlug: string) {
  return conceptStore.statsByJourney(journeySlug);
}

function getFlashcardCount (journeySlug: string) {
  const slugs = conceptStore.getByJourney(journeySlug).map((c) => c.slug);
  return flashcardStore.getByJourney(slugs).length;
}

function getPhaseCount (journeySlug: string) {
  return phaseStore.getByJourney(journeySlug).length;
}
</script>

<style>
.journey-card {
  border-color: var(--gui-neutral-border);
}
.journey-card:hover {
  border-color: var(--gui-neutral-solid);
}
.journey-card-title { color: var(--gui-neutral-fg); }
.journey-card-stats { color: var(--gui-neutral-solid); }
.journeys-empty { color: var(--gui-neutral-solid); }
</style>
