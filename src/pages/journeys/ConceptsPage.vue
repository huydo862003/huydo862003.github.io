<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <Breadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Concepts', to: `/journeys/${slug}/concepts` }]" />
    </div>
    <h1>Concepts <span class="count">({{ filteredConcepts.length }})</span></h1>

    <div class="filters">
      <input
        v-model="search"
        type="text"
        placeholder="Search..."
        class="input"
      >
    </div>

    <div
      v-if="pagedConcepts.length"
      class="table-scroll"
    >
      <table
        class="concept-table"
      >
        <thead>
          <tr>
            <th
              class="sortable col-concept"
              @click="toggleSort('title')"
            >
              Concept {{ sortIcon('title') }}
            </th>
            <th
              class="sortable col-status"
              @click="toggleSort('status')"
            >
              Status {{ sortIcon('status') }}
            </th>
            <th class="col-tags">
              Tags
            </th>
            <th class="col-books">
              Books
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="concept in pagedConcepts"
            :key="concept.slug"
            class="row"
            @click="router.push(`/journeys/${slug}/concepts/${concept.slug}`)"
          >
            <td
              v-tooltip="{ content: tooltipContent(concept.slug), html: true, delay: { show: 300, hide: 0 }, placement: 'top-start' }"
              class="font-medium"
            >
              <router-link
                :to="`/journeys/${slug}/concepts/${concept.slug}`"
                class="concept-link"
                @click.stop
              >
                {{ concept.title }}
              </router-link>
            </td>
            <td>
              <span
                v-tooltip="concept.status"
                class="status-ring"
                :style="{ '--progress': statusProgress(concept.status), '--ring-color': ringColor(statusProgress(concept.status)) }"
              />
            </td>
            <td>
              <span
                v-for="tag in displayTags(concept)"
                :key="tag"
                class="tag"
                :style="{ '--tag-hue': tagHue(tag) }"
              >{{ formatSlug(tag) }}</span>
            </td>
            <td>
              <router-link
                v-for="book in concept.books"
                :key="book"
                :to="`/journeys/${slug}/books`"
                class="book-link"
                @click.stop
              >
                {{ formatSlug(book) }}
              </router-link>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <p
      v-else
      class="empty"
    >
      No concepts match.
    </p>

    <div
      v-if="totalPages > 1"
      class="paging"
    >
      <button
        :disabled="page <= 1"
        class="page-btn"
        @click="page--"
      >
        &larr;
      </button>
      <span class="page-info">{{ page }} / {{ totalPages }}</span>
      <button
        :disabled="page >= totalPages"
        class="page-btn"
        @click="page++"
      >
        &rarr;
      </button>
    </div>

    <DetailModal
      :open="!!expanded"
      :title="expanded?.title ?? ''"
      @close="selected = undefined"
    >
      <template v-if="expanded">
        <div class="detail-meta">
          <span
            v-tooltip="expanded.status"
            class="status-ring"
            :style="{ '--progress': statusProgress(expanded.status), '--ring-color': ringColor(statusProgress(expanded.status)) }"
          />
          <span
            v-for="tag in displayTags(expanded)"
            :key="tag"
            class="tag"
            :style="{ '--tag-hue': tagHue(tag) }"
          >{{ formatSlug(tag) }}</span>
        </div>
        <CollapsibleList
          v-if="expanded.books.length"
          label="Books"
          :columns="1"
          :items="bookItems"
        />
        <div v-if="content">
          <h3 class="section-label">
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
import { useAsyncState } from '@vueuse/core';
import {
  useRoute, useRouter,
} from 'vue-router';
import Breadcrumb from '@/components/BreadcrumbNav.vue';
import { useTableSort } from '@/composables/use_table_sort';
import { useConceptStore } from '@/stores/concepts';
import {
  loadContent, getCachedContent,
} from '@/utils/content';
import {
  formatSlug, statusProgress, ringColor,
} from '@/utils/format';
import { tagHue } from '@/utils/color';
import CollapsibleList from '@/components/CollapsibleList.vue';
import DetailModal from '@/components/DetailModal.vue';
import type { Concept } from '@/types/concept';

const PAGE_SIZE = 50;

const route = useRoute();
const router = useRouter();
const slug = computed(() => route.params.slug as string);
const conceptStore = useConceptStore();

const search = ref('');
const {
  sortKey, sortAsc, toggleSort, sortIcon,
} = useTableSort('title');
const page = ref(1);
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

const sortedConcepts = computed(() => {
  if (!sortKey.value) return filteredConcepts.value;
  const list = [...filteredConcepts.value];
  const dir = sortAsc.value ? 1 : -1;
  if (sortKey.value === 'status') {
    list.sort((a, b) => dir * (statusOrder[a.status] - statusOrder[b.status]) || dir * a.title.localeCompare(b.title));
  } else {
    list.sort((a, b) => dir * a.title.localeCompare(b.title));
  }
  return list;
});

const totalPages = computed(() => Math.max(1, Math.ceil(sortedConcepts.value.length / PAGE_SIZE)));

const pagedConcepts = computed(() => {
  const start = (page.value - 1) * PAGE_SIZE;
  return sortedConcepts.value.slice(start, start + PAGE_SIZE);
});

watch([
  search,
  sortKey,
  sortAsc,
], () => {
  page.value = 1;
});

const expanded = computed(() =>
  journeyConcepts.value.find((c) => c.slug === selected.value));

const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => selected.value ? loadContent(selected.value) : '', '');
watch(selected, () => reloadContent());

const bookItems = computed(() =>
  (expanded.value?.books ?? []).map((b) => ({
    value: b,
    label: formatSlug(b),
    to: `/journeys/${slug.value}/books/${b}`,
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

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold mb-6;
}
.count {
  @apply text-sm font-normal text-fg-faint;
}
.filters {
  @apply flex flex-wrap items-center gap-2 mb-6;
}
.sort-dir {
  @apply text-xs px-2 py-1 border border-border rounded-sm text-fg-muted
         hover:border-fg-faint transition-colors cursor-pointer;
}
.concept-link {
  @apply text-xs text-fg no-underline hover:text-accent-blue hover:underline;
}
.table-scroll {
  @apply overflow-x-auto -mx-1 px-1;
}
.concept-table {
  @apply w-full text-xs border-collapse;
  min-width: 32rem;
}
.col-concept { min-width: 10rem; }
.col-status { min-width: 4rem; }
.col-tags { min-width: 8rem; }
.col-books { min-width: 8rem; }
.concept-table th {
  @apply text-left text-xs text-fg-faint font-medium pb-2 pr-4;
}
.concept-table td {
  @apply py-2 pr-4 border-t border-border;
}
.row {
  @apply cursor-pointer hover:bg-bg-subtle transition-colors;
}
.empty {
  @apply text-fg-faint text-sm;
}
.tag {
  @apply inline-block font-medium px-1 py-0 rounded mr-1 mb-0.5
         max-w-20 truncate align-middle;
  font-size: 0.6875rem;
  background: oklch(0.85 0.07 var(--tag-hue));
  color: oklch(0.38 0.1 var(--tag-hue));
}
.book-link {
  @apply inline-block text-xs text-fg-muted no-underline hover:underline mr-1;
}
.paging {
  @apply flex items-center justify-center gap-3 mt-6;
}
.page-btn {
  @apply text-sm px-2 py-1 border border-border rounded-sm text-fg-muted
         hover:border-fg-faint transition-colors cursor-pointer
         disabled:opacity-30 disabled:cursor-default;
}
.page-info {
  @apply text-xs text-fg-faint;
}
.detail-meta {
  @apply flex items-center gap-2 mb-4;
}
</style>

<style>
.dark .tag {
  background: oklch(0.28 0.05 var(--tag-hue)) !important;
  color: oklch(0.82 0.06 var(--tag-hue)) !important;
}
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
