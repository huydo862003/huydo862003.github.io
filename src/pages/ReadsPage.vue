<template>
  <div class="page reads-page">
    <h1 class="heading">
      Scrambled Reads
    </h1>
    <SFilterBar
      :groups="filterGroups"
      :model-values="filterValues"
      class="mb-4"
      @update:model-values="onFilterUpdate"
    />
    <ul class="reads-list">
      <li
        v-for="item in pagedReads"
        :key="`${item.type}-${item.slug}`"
        class="reads-item"
      >
        <component
          :is="item.to ? 'router-link' : 'a'"
          v-bind="item.to ? { to: item.to } : { href: item.url, target: '_blank', rel: 'noopener' }"
          class="reads-item-row"
          :class="{ 'reads-item-no-link': !item.to && !item.url }"
        >
          <span :class="`reads-type reads-type-${item.type}`">{{ item.type }}</span>
          <div class="reads-item-body">
            <span class="reads-item-title">{{ item.title }}</span>
            <span
              v-if="item.meta"
              class="reads-item-meta"
            >{{ item.meta }}</span>
          </div>
        </component>
      </li>
      <li
        v-for="i in READS_PAGE_SIZE - pagedReads.length"
        :key="`empty-${i}`"
        class="reads-item reads-item-empty"
      />
    </ul>
    <SPager
      v-model="readsPage"
      :total="readsPages"
      class="mt-4"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch,
} from 'vue';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useJourneyStore,
} from '@/stores/journeys';
import {
  useBookStore,
} from '@/stores/books';
import {
  useBlogs,
} from '@/stores/blogs';
import {
  usePaperStore,
} from '@/stores/papers';
import SFilterBar from '@/components/common/SFilterBar.vue';
import SPager from '@/components/common/SPager.vue';

useSeo({
  title: ref('Scrambled Reads'),
  description: ref('Books, blog posts, and papers from my reading list.'),
  path: ref('/reads'),
  type: 'website',
});

const {
  journeys,
} = useJourneyStore();
const bookStore = useBookStore();
const blogStore = useBlogs();
const paperStore = usePaperStore();

const READS_PAGE_SIZE = 5;
const readsJourneys = ref<string[]>([]);
const readsTypes = ref<string[]>([]);
const readsPage = ref(1);

const readsStats = computed(() => {
  const js = readsJourneys.value;
  const books = js.length
    ? js.flatMap((j) => bookStore.getByJourney(j)).filter((b) => !b.parent)
    : bookStore.books.filter((b) => !b.parent);
  const blogs = js.length
    ? js.flatMap((j) => blogStore.getPosts(j))
    : blogStore.posts;
  const papers = js.length
    ? js.flatMap((j) => paperStore.getByJourney(j))
    : paperStore.papers;

  return [
    {
      label: 'books',
      type: 'book',
      count: books.length,
    },
    {
      label: 'posts',
      type: 'post',
      count: blogs.length,
    },
    {
      label: 'papers',
      type: 'paper',
      count: papers.length,
    },
  ];
});

const readsItems = computed(() => {
  const js = readsJourneys.value;
  const ts = readsTypes.value;

  const books = (js.length ? js.flatMap((j) => bookStore.getByJourney(j)) : bookStore.books)
    .filter((b) => !b.parent)
    .map((b) => ({
      slug: b.slug,
      type: 'book',
      title: b.title,
      to: `/journeys/${b.journey}/books/${b.slug}`,
      url: '',
      meta: [
        b.author,
        b.date,
      ].filter(Boolean).join(' · '),
    }));

  const blogs = (js.length ? js.flatMap((j) => blogStore.getPosts(j)) : blogStore.posts)
    .map((b) => ({
      slug: b.slug,
      type: 'post',
      title: b.title,
      url: b.url,
      meta: b.author,
    }));

  const papers = (js.length ? js.flatMap((j) => paperStore.getByJourney(j)) : paperStore.papers)
    .map((p) => ({
      slug: p.slug,
      type: 'paper',
      title: p.title,
      to: `/journeys/${p.journey}/papers/${p.slug}`,
      url: p.url,
      meta: [
        p.authors.join(', '),
        p.venue,
        p.year,
      ].filter(Boolean).join(' · '),
    }));

  const all = [
    ...books,
    ...blogs,
    ...papers,
  ];
  return ts.length ? all.filter((item) => ts.includes(item.type)) : all;
});

const readsPages = computed(() => Math.max(1, Math.ceil(readsItems.value.length / READS_PAGE_SIZE)));
const pagedReads = computed(() => {
  const start = (readsPage.value - 1) * READS_PAGE_SIZE;
  return readsItems.value.slice(start, start + READS_PAGE_SIZE);
});

watch([
  readsJourneys,
  readsTypes,
], () => {
  readsPage.value = 1;
}, {
  deep: true,
});

const filterGroups = computed(() => [
  journeys.map((j) => ({
    label: j.title,
    value: j.slug,
  })),
  readsStats.value.map((r) => ({
    label: `${r.count} ${r.label}`,
    value: r.type,
    colorClass: r.type,
  })),
]);

const filterValues = computed(() => [
  readsJourneys.value,
  readsTypes.value,
]);

function onFilterUpdate (values: string[][]) {
  readsJourneys.value = values[0];
  readsTypes.value = values[1];
}
</script>

<style scoped>
@reference "../style.css";
.reads-page {
  max-width: 42rem;
}
.heading {
  @apply text-base font-bold mb-4 pb-2 border-b border-border;
}
.reads-list {
  @apply list-none p-0 m-0 flex flex-col;
}
.reads-item {
  @apply border-b border-border/50;
  height: 3.25rem;
}
.reads-item-empty {
  @apply border-b border-border/20;
}
.reads-item-row {
  @apply flex items-start gap-2 no-underline w-full h-full px-1 -mx-1 rounded-sm
         transition-colors cursor-pointer;
  padding-top: 0.625rem;
}
.reads-item-row:hover {
  @apply bg-bg-subtle;
}
.reads-item-row:hover .reads-item-title {
  @apply text-accent-blue;
}
.reads-item-no-link {
  @apply cursor-default;
}
.reads-item-no-link:hover {
  @apply bg-transparent;
}
.reads-item-body {
  @apply flex flex-col min-w-0 flex-1;
}
.reads-item-title {
  @apply text-xs text-fg-muted transition-colors truncate;
  line-height: 1.2rem;
  margin-bottom: 0.2rem;
}
.reads-item-meta {
  @apply text-fg-faint truncate;
  font-size: 0.625rem;
  line-height: 1rem;
}
.reads-type {
  @apply shrink-0 px-1.5 rounded-sm;
  font-size: 0.625rem;
  line-height: 1.2rem;
}
.reads-type-book {
  @apply bg-accent-blue/10 text-accent-blue;
}
.reads-type-post {
  @apply bg-accent-green/10 text-accent-green;
}
.reads-type-paper {
  @apply bg-accent-yellow/10 text-accent-yellow;
}
</style>
