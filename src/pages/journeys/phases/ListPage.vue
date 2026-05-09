<template>
  <div class="page">
    <div class="top-bar">
      <RouterLink
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </RouterLink>
      <JourneyBreadcrumb
        :crumbs="[
          {
            label: 'Journeys',
            to: '/journeys',
          },
          {
            label: slug,
            to: `/journeys/${slug}`,
          },
          {
            label: 'Phases',
            to: `/journeys/${slug}/phases`,
          },
        ]"
      />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Phases
    </h1>

    <GFilterable
      v-if="phases.length"
      :columns="1"
      :page-size="20"
    >
      <GFilterableItem
        v-for="phase in phases"
        :key="phase.slug"
        :value="phase.slug"
        :label="phase.title"
      >
        <RouterLink
          :to="`/journeys/${slug}/phases/${phase.slug}`"
          class="phase-card block border rounded-sm px-4 py-3 no-underline transition-colors"
        >
          <div class="flex flex-wrap items-center justify-between gap-1">
            <span
              class="phase-title text-sm font-medium"
            >{{ phase.title }}</span>
            <span :class="`status-${phase.status}`">{{ phase.status }}</span>
          </div>
          <div
            v-if="phase.concepts.length || phase.books.length"
            class="phase-stats flex flex-wrap gap-x-3 gap-y-0.5 mt-2 text-xs"
          >
            <span v-if="phase.concepts.length">{{ phase.concepts.length }} concepts</span>
            <span v-if="phase.books.length">{{ phase.books.length }} books</span>
          </div>
        </RouterLink>
      </GFilterableItem>
    </GFilterable>

    <p
      v-if="!phases.length"
      class="content-empty text-sm"
    >
      No phases yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  useRoute,
} from 'vue-router';
import {
  GFilterable, GFilterableItem,
} from '@hdnax/genuix';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  usePhaseStore,
} from '@/stores/phases';
import {
  useSeo,
} from '@/composables/useSeo';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const phaseStore = usePhaseStore();

useSeo({
  title: computed(() => `Phases - ${slug.value}`),
  path: computed(() => `/journeys/${slug.value}/phases`),
  type: 'website',
});

const phases = computed(() => phaseStore.getByJourney(slug.value));
</script>

<style scoped>
.phase-card { border-color: var(--gui-neutral-border); }
.phase-card:hover { border-color: var(--gui-neutral-solid); }
.phase-title { color: var(--gui-neutral-fg); }
.phase-stats { color: var(--gui-neutral-solid); }
</style>
