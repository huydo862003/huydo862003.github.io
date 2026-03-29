<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Papers', to: `/journeys/${slug}/papers` }]" />
    </div>
    <h1>Papers</h1>

    <div
      v-if="papers.length"
      class="filter-row"
    >
      <input
        v-model="search"
        type="text"
        placeholder="Filter papers..."
        class="filter-input"
      >
      <SFilterBar
        :groups="[statusGroup]"
        :model-values="[statusFilter]"
        placeholder="Status"
        @update:model-values="statusFilter = $event[0]"
      />
    </div>

    <ul
      v-if="filtered.length"
      class="list"
    >
      <li
        v-for="paper in filtered"
        :key="paper.slug"
        class="item"
      >
        <div class="item-row">
          <a
            v-if="paper.url"
            :href="paper.url"
            target="_blank"
            rel="noopener"
            class="item-title"
          >{{ paper.title }}</a>
          <span
            v-else
            class="item-title no-link"
          >{{ paper.title }}</span>
          <span :class="`status-${paper.status}`">{{ paper.status }}</span>
        </div>
        <div class="item-meta">
          <span
            v-if="paper.authors.length"
            class="authors"
          >{{ paper.authors.join(', ') }}</span>
          <span
            v-if="paper.venue"
            class="venue"
          >{{ paper.venue }}</span>
          <span
            v-if="paper.year"
            class="year"
          >{{ paper.year }}</span>
        </div>
        <div
          v-if="paper.tags.length"
          class="tags"
        >
          <span
            v-for="t in paper.tags"
            :key="t"
            class="tag"
          >{{ t }}</span>
        </div>
      </li>
    </ul>

    <p
      v-else-if="papers.length && !filtered.length"
      class="empty"
    >
      No papers match your filter.
    </p>
    <p
      v-else
      class="empty"
    >
      No papers yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed,
} from 'vue';
import { useRoute } from 'vue-router';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import SFilterBar from '@/components/common/SFilterBar.vue';
import { usePaperStore } from '@/stores/papers';
import { useSeo } from '@/composables/useSeo';

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

const statusGroup = [
  {
    label: 'To read',
    value: 'to-read',
  },
  {
    label: 'Reading',
    value: 'reading',
  },
  {
    label: 'Read',
    value: 'read',
  },
];

const filtered = computed(() => {
  let result = papers.value;
  if (statusFilter.value.length) {
    result = result.filter((p) => statusFilter.value.includes(p.status));
  }
  if (search.value) {
    const q = search.value.toLowerCase();
    result = result.filter((p) =>
      p.title.toLowerCase().includes(q)
      || p.authors.some((a) => a.toLowerCase().includes(q))
      || p.venue.toLowerCase().includes(q));
  }
  return result;
});
</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold mb-4;
}
.filter-row {
  @apply flex flex-wrap items-center gap-2 mb-6;
}
.filter-input {
  @apply text-xs px-2 py-1 bg-transparent text-fg border border-border
         rounded-sm outline-none flex-1 min-w-40 placeholder:text-fg-faint/40
         focus:border-fg-faint transition-colors;
}
.list {
  @apply list-none p-0 m-0 flex flex-col gap-3;
}
.item {
  @apply border-l-2 border-border pl-3 py-1.5;
}
.item-row {
  @apply flex flex-wrap items-center justify-between gap-2;
}
.item-title {
  @apply text-sm font-medium text-fg-muted no-underline hover:text-accent-blue transition-colors;
}
.item-title.no-link {
  @apply hover:text-fg-muted cursor-default;
}
.item-meta {
  @apply flex flex-wrap items-center gap-x-2 mt-0.5;
}
.authors {
  @apply text-xs text-fg-faint;
}
.venue {
  @apply text-xs text-fg-faint before:content-['·'] before:mr-2;
}
.year {
  @apply text-xs text-fg-faint tabular-nums;
}
.tags {
  @apply flex flex-wrap gap-1 mt-1;
}
.tag {
  @apply text-fg-faint border border-border rounded-sm px-1.5;
  font-size: 0.625rem;
  line-height: 1.25rem;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
