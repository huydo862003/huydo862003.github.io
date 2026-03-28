<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <Breadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Phases', to: `/journeys/${slug}/phases` }]" />
    </div>
    <h1>Phases</h1>

    <ul class="phases">
      <li
        v-for="phase in phases"
        :key="phase.slug"
      >
        <router-link
          :to="`/journeys/${slug}/phases/${phase.slug}`"
          class="phase"
        >
          <div class="phase-header">
            <span class="phase-title">{{ phase.title }}</span>
            <span :class="`status-${phase.status}`">{{ phase.status }}</span>
          </div>
          <div
            v-if="phase.concepts.length || phase.books.length"
            class="phase-meta"
          >
            <span v-if="phase.concepts.length">{{ phase.concepts.length }} concepts</span>
            <span v-if="phase.books.length">{{ phase.books.length }} books</span>
          </div>
        </router-link>
      </li>
    </ul>

    <p
      v-if="!phases.length"
      class="empty"
    >
      No phases yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import Breadcrumb from '@/components/BreadcrumbNav.vue';
import { usePhaseStore } from '@/stores/phases';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const phaseStore = usePhaseStore();

const phases = computed(() => phaseStore.getByJourney(slug.value));
</script>

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold mb-6;
}
.phases {
  @apply list-none p-0 m-0 flex flex-col gap-2;
}
.phase {
  @apply block border border-border rounded-sm px-4 py-3 no-underline
         hover:border-fg-faint transition-colors;
}
.phase-header {
  @apply flex flex-wrap items-center justify-between gap-1;
}
.phase-title {
  @apply text-sm font-medium text-fg;
}
.phase-meta {
  @apply flex flex-wrap gap-x-3 gap-y-0.5 mt-2 text-xs text-fg-faint;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
