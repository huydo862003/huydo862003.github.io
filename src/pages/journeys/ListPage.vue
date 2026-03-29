<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        to="/"
        class="back"
      >
        &larr; home
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }]" />
    </div>
    <h1>Scrambled Journeys</h1>

    <div
      v-if="journeys.length"
      class="journey-list"
    >
      <router-link
        v-for="j in journeys"
        :key="j.slug"
        :to="`/journeys/${j.slug}`"
        class="journey-card"
      >
        <div class="card-top">
          <span class="card-title">{{ j.title }}</span>
          <span :class="['card-status', `status-${j.status}`]">{{ j.status }}</span>
        </div>
        <div class="card-stats">
          <span>{{ plural(getConceptStats(j.slug).total, 'concept') }}</span>
          <span>{{ plural(getFlashcardCount(j.slug), 'flashcard') }}</span>
          <span>{{ plural(getPhaseCount(j.slug), 'phase') }}</span>
        </div>
      </router-link>
    </div>

    <p
      v-else
      class="empty"
    >
      No journeys yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useJourneyStore } from '@/stores/journeys';
import { useConceptStore } from '@/stores/concepts';
import { useFlashcardStore } from '@/stores/flashcards';
import { usePhaseStore } from '@/stores/phases';
import {
  plural,
} from '@/utils/format';

const { journeys } = useJourneyStore();
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

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold mb-6;
}
.journey-list {
  @apply flex flex-col gap-2;
}
.journey-card {
  @apply block border border-border rounded-sm px-3 py-2.5 sm:px-4 sm:py-3 no-underline
         hover:border-fg-faint transition-colors;
}
.card-top {
  @apply flex flex-wrap items-center justify-between gap-1;
}
.card-title {
  @apply text-sm font-semibold text-fg;
}
.card-stats {
  @apply flex flex-wrap gap-x-3 gap-y-0.5 mt-1 text-xs text-fg-faint;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
