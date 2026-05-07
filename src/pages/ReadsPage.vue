<template>
  <div class="page reads-page">
    <h1 class="heading">
      Scrambled Reads
    </h1>
    <FilterBar
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
    <PagePager
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
import PagePager from './PagePager.vue';
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
import FilterBar from '@/components/common/FilterBar.vue';

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
    ? js.flatMap((index) => bookStore.getByJourney(index)).filter((book) => !book.parent)
    : bookStore.books.filter((book) => !book.parent);
  const blogs = js.length
    ? js.flatMap((index) => blogStore.getPosts(index))
    : blogStore.posts;
  const papers = js.length
    ? js.flatMap((index) => paperStore.getByJourney(index))
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

  const books = (js.length ? js.flatMap((index) => bookStore.getByJourney(index)) : bookStore.books)
    .filter((book) => !book.parent)
    .map((book) => ({
      slug: book.slug,
      type: 'book',
      title: book.title,
      to: `/journeys/${book.journey}/books/${book.slug}`,
      url: '',
      meta: [
        book.author,
        book.date,
      ].filter(Boolean).join(' · '),
    }));

  const blogs = (js.length ? js.flatMap((index) => blogStore.getPosts(index)) : blogStore.posts)
    .map((post) => ({
      slug: post.slug,
      type: 'post',
      title: post.title,
      url: post.url,
      meta: post.author,
    }));

  const papers = (js.length ? js.flatMap((index) => paperStore.getByJourney(index)) : paperStore.papers)
    .map((paper) => ({
      slug: paper.slug,
      type: 'paper',
      title: paper.title,
      to: `/journeys/${paper.journey}/papers/${paper.slug}`,
      url: paper.url,
      meta: [
        paper.authors.join(', '),
        paper.venue,
        paper.year,
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
  journeys.map((index) => ({
    label: index.title,
    value: index.slug,
  })),
  readsStats.value.map((stat) => ({
    label: `${stat.count} ${stat.label}`,
    value: stat.type,
    colorClass: stat.type,
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
@reference "@/style.css";
.reads-page {
}
.heading {
  @apply text-base font-bold mb-4 pb-2 border-b;
  border-color: var(--gui-neutral-border);
}
.reads-list {
  @apply list-none p-0 m-0 flex flex-col;
}
.reads-item {
  @apply border-b h-14;
  border-color: color-mix(in oklch, var(--gui-neutral-border) 50%, transparent);
}
.reads-item-empty {
  @apply border-b;
  border-color: color-mix(in oklch, var(--gui-neutral-border) 20%, transparent);
}
.reads-item-row {
  @apply flex items-start gap-2 no-underline w-full h-full rounded-sm p-1
         transition-colors cursor-pointer;
  padding-top: 0.5rem;
}
.reads-item:hover {
  background-color: var(--gui-neutral-bg-subtle);
}
.reads-item-row:hover .reads-item-title {
  color: var(--gui-info-solid);
}
.reads-item-no-link {
  @apply cursor-default;
}
.reads-item-no-link:hover {
  background: transparent;
}
.reads-item-body {
  @apply flex flex-col min-w-0 flex-1;
}
.reads-item-title {
  @apply text-xs transition-colors truncate;
  color: var(--gui-neutral-fg-muted);
  line-height: 1.2rem;
  margin-bottom: 0.2rem;
}
.reads-item-meta {
  @apply truncate;
  color: var(--gui-neutral-solid);
  font-size: 0.625rem;
  line-height: 1rem;
}
.reads-type {
  @apply shrink-0 px-1.5 rounded-sm;
  font-size: 0.625rem;
  line-height: 1.2rem;
}
.reads-type-book {
  background-color: color-mix(in oklch, var(--gui-info-solid) 10%, transparent);
  color: var(--gui-info-solid);
}
.reads-type-post {
  background-color: color-mix(in oklch, var(--gui-success-solid) 10%, transparent);
  color: var(--gui-success-solid);
}
.reads-type-paper {
  background-color: color-mix(in oklch, var(--gui-warning-solid) 10%, transparent);
  color: var(--gui-warning-solid);
}
</style>
