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
            label: 'Concepts',
            to: `/journeys/${slug}/concepts`,
          },
        ]"
      />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Concepts <span
        class="concepts-count text-sm font-normal"
      >({{ filteredConcepts.length }})</span>
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
              class="col-concept px-3"
            >
              Concept <GTableSorter col-key="title" />
            </GTableCell>
            <GTableCell
              header
              class="col-status px-3"
            >
              Status <GTableSorter col-key="status" />
            </GTableCell>
            <GTableCell
              header
              class="col-tags px-3"
            >
              Tags
            </GTableCell>
            <GTableCell
              header
              class="col-books px-3"
            >
              Books
            </GTableCell>
          </GTableRow>
        </GTableHeader>
        <GTableBody>
          <GTableRow
            v-for="concept in filteredConcepts"
            :key="concept.slug"
            :row-data="{
              title: concept.title,
              status: statusOrder[concept.status] ?? 0,
            }"
            class="concept-row cursor-pointer transition-colors"
            @click="() => navigateToConcept(concept.slug)"
          >
            <GTableCell
              v-tooltip="{
                content: tooltipContent(concept.slug),
                html: true,
                delay: {
                  show: 300,
                  hide: 0,
                },
                placement: 'top-start',
              }"
              class="col-concept font-medium px-3"
            >
              <RouterLink
                :to="`/journeys/${slug}/concepts/${concept.slug}`"
                class="concept-link text-xs no-underline hover:underline"
                @click.stop
              >
                {{ concept.title }}
              </RouterLink>
            </GTableCell>
            <GTableCell
              class="col-status px-3"
            >
              <span
                v-tooltip="concept.status"
                class="status-ring"
                :style="{
                  '--progress': statusProgress(concept.status),
                  '--ring-color': ringColor(statusProgress(concept.status)),
                }"
              />
            </GTableCell>
            <GTableCell
              class="col-tags px-3"
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
              class="col-books px-3"
            >
              <div class="flex flex-nowrap overflow-hidden items-center gap-1">
                <RouterLink
                  v-for="book in concept.books"
                  :key="book"
                  :to="`/journeys/${slug}/books`"
                  class="book-link inline-block text-xs no-underline hover:underline mr-1"
                  @click.stop
                >
                  {{ formatSlug(book) }}
                </RouterLink>
              </div>
            </GTableCell>
          </GTableRow>
        </GTableBody>
      </GTable>
    </div>
    <p
      v-else-if="!filteredConcepts.length"
      class="content-empty text-sm mt-4"
    >
      No concepts match.
    </p>

    <DetailModal
      :open="Boolean(expanded)"
      :title="expanded?.title ?? ''"
      @close="clearSelected"
    >
      <template v-if="expanded">
        <div class="flex items-center gap-2 mb-4">
          <span
            v-tooltip="expanded.status"
            class="status-ring"
            :style="{
              '--progress': statusProgress(expanded.status),
              '--ring-color': ringColor(statusProgress(expanded.status)),
            }"
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
          <h3 class="section-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
            Content
          </h3>
          <div
            class="prose"
            v-html="content"
          />
        </div>
        <p
          v-else
          class="modal-empty text-sm"
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
  journeyConcepts.value.filter((concept) => {
    if (search.value && !concept.title.toLowerCase().includes(search.value.toLowerCase())) return false;

    return true;
  }));

const expanded = computed(() =>
  journeyConcepts.value.find((concept) => concept.slug === selected.value));

const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => selected.value ? loadContent(selected.value) : '',
  '',
);

watch(selected, () => reloadContent());

const bookItems = computed(() =>
  (expanded.value?.books ?? []).map((bookSlug) => ({
    value: bookSlug,
    label: formatSlug(bookSlug),
    to: `/journeys/${slug.value}/books/${bookSlug}`,
    as: RouterLink,
  })));

function clearSelected () {
  selected.value = undefined;
}

function displayTags (concept: Concept): string[] {
  return concept.tags;
}

function navigateToConcept (conceptSlug: string) {
  router.push(`/journeys/${slug.value}/concepts/${conceptSlug}`);
}

function tooltipContent (conceptSlug: string): string {
  const html = getCachedContent(conceptSlug);

  if (!html) return '<em>No definition yet.</em>';
  const firstP = html.match(/<p>([\s\S]*?)<\/p>/);
  const preview = firstP ? firstP[0] : html.slice(0, 400);

  return `<div class="tooltip-def">${preview}</div>`;
}
</script>

<style scoped>
.concepts-count { color: var(--gui-neutral-solid); }
.col-concept { min-width: 10rem; }
.col-status { min-width: 4rem; }
.col-tags { min-width: 8rem; }
.col-books { min-width: 8rem; }
.concept-link { color: var(--gui-neutral-fg); }
.book-link { color: var(--gui-neutral-fg-muted); }
.modal-empty { color: var(--gui-neutral-solid); }
:global(.concept-row:hover) { background-color: var(--gui-neutral-bg-subtle); }
:global(.concept-link:hover) { color: var(--gui-info-solid); }
:global(.tooltip-def) {
  max-width: 400px;
  max-height: 200px;
  overflow: hidden;
  font-size: 12px;
  line-height: 1.5;
}
:global(.tooltip-def em) {
  font-size: 11px;
  opacity: 0.6;
}
:global(.v-popper--theme-tooltip .v-popper__inner) {
  background: #1a1a2e !important;
  color: #e8e8f0 !important;
  border: 1px solid #3a3a5c !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4) !important;
  padding: 10px 14px !important;
  border-radius: 6px !important;
}
:global(.v-popper--theme-tooltip .v-popper__arrow-outer) {
  border-color: #3a3a5c !important;
}
:global(.v-popper--theme-tooltip .v-popper__arrow-inner) {
  border-color: #1a1a2e !important;
}
</style>
