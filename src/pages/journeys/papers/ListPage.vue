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
            label: 'Papers',
            to: `/journeys/${slug}/papers`,
          },
        ]"
      />
    </div>
    <h1 class="text-xl font-bold mb-4">
      Papers
    </h1>

    <div
      v-if="papers.length"
      class="flex flex-wrap items-center gap-2 mb-6"
    >
      <GTextInput
        v-model="search"
        placeholder="Filter papers..."
        class="flex-1 min-w-40"
      />
      <GMultiSelect
        v-model="statusFilter"
        placeholder="Status"
      >
        <GMultiSelectOption
          value="to-read"
          label="To read"
        />
        <GMultiSelectOption
          value="reading"
          label="Reading"
        />
        <GMultiSelectOption
          value="read"
          label="Read"
        />
      </GMultiSelect>
    </div>

    <div
      v-if="filtered.length"
      class="overflow-auto"
    >
      <GTable>
        <GTableHeader>
          <GTableRow>
            <GTableCell
              header
              class="px-3"
            >
              Paper
            </GTableCell>
            <GTableCell
              header
              class="px-3"
            >
              Authors
            </GTableCell>
            <GTableCell
              header
              class="px-3"
            >
              Status
            </GTableCell>
            <GTableCell
              header
              class="px-3"
            >
              Tags
            </GTableCell>
          </GTableRow>
        </GTableHeader>
        <GTableBody>
          <GTableRow
            v-for="paper in filtered"
            :key="paper.slug"
            class="paper-row transition-colors"
          >
            <GTableCell class="px-3">
              <a
                v-if="paper.url"
                :href="paper.url"
                target="_blank"
                rel="noopener noreferrer"
                class="paper-title-link text-sm font-medium no-underline transition-colors"
              >{{ paper.title }}</a>
              <span
                v-else
                class="paper-title text-sm font-medium"
              >{{ paper.title }}</span>
              <div
                v-if="paper.venue || paper.year"
                class="paper-venue flex gap-2 text-xs mt-0.5"
              >
                <span v-if="paper.venue">{{ paper.venue }}</span>
                <span
                  v-if="paper.year"
                  class="tabular-nums"
                >{{ paper.year }}</span>
              </div>
            </GTableCell>
            <GTableCell
              class="paper-authors px-3 text-xs whitespace-nowrap"
            >
              {{ paper.authors.join(', ') }}
            </GTableCell>
            <GTableCell class="px-3">
              <span :class="`status-${paper.status}`">{{ paper.status }}</span>
            </GTableCell>
            <GTableCell class="px-3">
              <div class="flex flex-nowrap overflow-hidden gap-1">
                <GPill
                  v-for="t in paper.tags"
                  :key="t"
                  :prominence="GProminence.Secondary"
                  :size="GPillSize.Xs"
                  :color="GPillColor.Gray"
                >
                  {{ t }}
                </GPill>
              </div>
            </GTableCell>
          </GTableRow>
        </GTableBody>
      </GTable>
    </div>

    <p
      v-else-if="papers.length && !filtered.length"
      class="content-empty text-sm"
    >
      No papers match your filter.
    </p>
    <p
      v-else
      class="papers-empty text-sm"
    >
      No papers yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed,
} from 'vue';
import {
  useRoute,
} from 'vue-router';
import {
  GPill, GPillColor, GPillSize, GProminence, GTextInput,
  GTable, GTableHeader, GTableBody, GTableRow, GTableCell,
  GMultiSelect, GMultiSelectOption,
} from '@hdnax/genuix';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  usePaperStore,
} from '@/stores/papers';
import {
  useSeo,
} from '@/composables/useSeo';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const paperStore = usePaperStore();

useSeo({
  title: computed(() => `Papers - ${slug.value}`),
  path: computed(() => `/journeys/${slug.value}/papers`),
  type: 'website',
});

const papers = computed(() => paperStore.getByJourney(slug.value));
const search = ref('');
const statusFilter = ref<string[]>([]);

const filtered = computed(() => {
  let result = papers.value;

  if (statusFilter.value.length) {
    result = result.filter((paper) => statusFilter.value.includes(paper.status));
  }
  if (search.value) {
    const searchQuery = search.value.toLowerCase();

    result = result.filter((paper) =>
      paper.title.toLowerCase().includes(searchQuery)
      || paper.authors.some((author) => author.toLowerCase().includes(searchQuery))
      || paper.venue.toLowerCase().includes(searchQuery));
  }

  return result;
});
</script>

<style scoped>
.paper-title-link { color: var(--gui-neutral-fg-muted); }
.paper-title { color: var(--gui-neutral-fg-muted); }
.paper-venue { color: var(--gui-neutral-solid); }
.paper-authors { color: var(--gui-neutral-solid); }
:global(.paper-row:hover) { background-color: var(--gui-neutral-bg-subtle); }
:global(.paper-title-link:hover) { color: var(--gui-info-solid); }
</style>
