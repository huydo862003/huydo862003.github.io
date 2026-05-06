<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Concepts', to: `/journeys/${slug}/concepts` }]" />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Concepts <span class="text-sm font-normal text-fg-faint">({{ filteredConcepts.length }})</span>
    </h1>

    <div class="flex flex-wrap items-center gap-2 mb-6">
      <GTextInput
        v-model="search"
        placeholder="Search..."
      />
    </div>

    <div
      v-if="filteredConcepts.length"
      class="overflow-auto"
    >
      <GTable :page-size="PAGE_SIZE">
        <GTableHeader>
          <GTableRow>
            <GTableCell
              header
              class="px-3"
              style="min-width: 10rem"
            >
              Concept <GTableSorter col-key="title" />
            </GTableCell>
            <GTableCell
              header
              class="px-3"
              style="min-width: 4rem"
            >
              Status <GTableSorter col-key="status" />
            </GTableCell>
            <GTableCell
              header
              class="px-3"
              style="min-width: 8rem"
            >
              Tags
            </GTableCell>
            <GTableCell
              header
              class="px-3"
              style="min-width: 8rem"
            >
              Books
            </GTableCell>
          </GTableRow>
        </GTableHeader>
        <GTableBody>
          <GTableRow
            v-for="concept in filteredConcepts"
            :key="concept.slug"
            :row-data="{ title: concept.title, status: statusOrder[concept.status] ?? 0 }"
            class="cursor-pointer hover:bg-bg-subtle transition-colors"
            @click="router.push(`/journeys/${slug}/concepts/${concept.slug}`)"
          >
            <GTableCell
              v-tooltip="{ content: tooltipContent(concept.slug), html: true, delay: { show: 300, hide: 0 }, placement: 'top-start' }"
              class="font-medium px-3"
              style="min-width: 10rem"
            >
              <router-link
                :to="`/journeys/${slug}/concepts/${concept.slug}`"
                class="text-xs text-fg no-underline hover:text-accent-blue hover:underline"
                @click.stop
              >
                {{ concept.title }}
              </router-link>
            </GTableCell>
            <GTableCell
              class="px-3"
              style="min-width: 4rem"
            >
              <span
                v-tooltip="concept.status"
                class="status-ring"
                :style="{ '--progress': statusProgress(concept.status), '--ring-color': ringColor(statusProgress(concept.status)) }"
              />
            </GTableCell>
            <GTableCell
              class="px-3"
              style="min-width: 8rem"
            >
              <div class="flex flex-nowrap overflow-hidden items-center gap-1">
                <GPill
                  v-for="tag in displayTags(concept)"
                  :key="tag"
                  :prominence="GProminence.Secondary"
                  :size="GPillSize.Xs"
                  :color="GPillColor.Gray"
                >
                  {{ formatSlug(tag) }}
                </GPill>
              </div>
            </GTableCell>
            <GTableCell
              class="px-3"
              style="min-width: 8rem"
            >
              <div class="flex flex-nowrap overflow-hidden items-center gap-1">
                <router-link
                  v-for="book in concept.books"
                  :key="book"
                  :to="`/journeys/${slug}/books`"
                  class="inline-block text-xs text-fg-muted no-underline hover:underline mr-1"
                  @click.stop
                >
                  {{ formatSlug(book) }}
                </router-link>
              </div>
            </GTableCell>
          </GTableRow>
        </GTableBody>
      </GTable>
    </div>
    <p
      v-else-if="!filteredConcepts.length"
      class="text-fg-faint text-sm mt-4"
    >
      No concepts match.
    </p>

    <DetailModal
      :open="!!expanded"
      :title="expanded?.title ?? ''"
      @close="selected = undefined"
    >
      <template v-if="expanded">
        <div class="flex items-center gap-2 mb-4">
          <span
            v-tooltip="expanded.status"
            class="status-ring"
            :style="{ '--progress': statusProgress(expanded.status), '--ring-color': ringColor(statusProgress(expanded.status)) }"
          />
          <GPill
            v-for="tag in displayTags(expanded)"
            :key="tag"
            :prominence="GProminence.Secondary"
            :size="GPillSize.Xs"
            :color="GPillColor.Gray"
          >
            {{ formatSlug(tag) }}
          </GPill>
        </div>
        <GFilterable
          v-if="expanded.books.length"
          label="Books"
          :columns="1"
          :items="bookItems"
        />
        <div v-if="content">
          <h3 class="text-xs font-semibold text-fg-faint uppercase tracking-wider mb-3 pb-1 border-b border-border">
            Content
          </h3>
          <div
            class="prose"
            v-html="content"
          />
        </div>
        <p
          v-else
          class="text-sm text-fg-faint"
        >
          No content yet.
        </p>
      </template>
    </DetailModal>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute, useRouter, RouterLink,
} from 'vue-router';
import {
  GFilterable,
  GTable, GTableHeader, GTableBody, GTableRow, GTableCell, GTableSorter,
  GPill, GPillColor, GPillSize, GProminence,
  GTextInput,
} from '@hdnax/genuix';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  loadContent, getCachedContent,
} from '@/utils/content';
import {
  formatSlug, statusProgress, ringColor,
} from '@/utils/format';
import DetailModal from '@/components/modal/DetailModal.vue';
import type {
  Concept,
} from '@/types/concept';

const PAGE_SIZE = 50;

const route = useRoute();
const router = useRouter();
const slug = computed(() => route.params.slug as string);
const conceptStore = useConceptStore();

useSeo({
  title: computed(() => `Concepts - ${slug.value}`),
  path: computed(() => `/journeys/${slug.value}/concepts`),
  type: 'website',
});

const search = ref('');
const selected = ref<string | undefined>();

const statusOrder: Record<string, number> = {
  learning: 0,
  reviewing: 1,
  mastered: 2,
};

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));

const filteredConcepts = computed(() =>
  journeyConcepts.value.filter((c) => {
    if (search.value && !c.title.toLowerCase().includes(search.value.toLowerCase())) return false;
    return true;
  }));

const expanded = computed(() =>
  journeyConcepts.value.find((c) => c.slug === selected.value));

const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => selected.value ? loadContent(selected.value) : '',
  '',
);
watch(selected, () => reloadContent());

const bookItems = computed(() =>
  (expanded.value?.books ?? []).map((b) => ({
    value: b,
    label: formatSlug(b),
    to: `/journeys/${slug.value}/books/${b}`,
    as: RouterLink,
  })));

function displayTags (concept: Concept): string[] {
  return concept.tags;
}

function tooltipContent (conceptSlug: string): string {
  const html = getCachedContent(conceptSlug);
  if (!html) return '<em>No definition yet.</em>';
  const firstP = html.match(/<p>([\s\S]*?)<\/p>/);
  const preview = firstP ? firstP[0] : html.slice(0, 400);
  return `<div class="tooltip-def">${preview}</div>`;
}
</script>

<style>
.tooltip-def {
  max-width: 400px;
  max-height: 200px;
  overflow: hidden;
  font-size: 12px;
  line-height: 1.5;
}
.tooltip-def em {
  font-size: 11px;
  opacity: 0.6;
}
.v-popper--theme-tooltip .v-popper__inner {
  background: #1a1a2e !important;
  color: #e8e8f0 !important;
  border: 1px solid #3a3a5c !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4) !important;
  padding: 10px 14px !important;
  border-radius: 6px !important;
}
.v-popper--theme-tooltip .v-popper__arrow-outer {
  border-color: #3a3a5c !important;
}
.v-popper--theme-tooltip .v-popper__arrow-inner {
  border-color: #1a1a2e !important;
}
</style>
