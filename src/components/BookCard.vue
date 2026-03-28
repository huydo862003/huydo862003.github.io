<template>
  <div class="book-card">
    <router-link
      :to="`/journeys/${journeySlug}/books/${book.slug}`"
      class="book-title"
    >
      <PhBook :size="14" />
      {{ book.title }}
    </router-link>
    <p
      v-if="book.author || book.date"
      class="book-meta"
    >
      <span v-if="book.author">{{ book.author }}</span>
      <span v-if="book.author && book.date"> · </span>
      <span v-if="book.date">{{ book.date }}</span>
    </p>
    <ChapterList
      v-if="children.length"
      :chapters="children"
      :journey-slug="journeySlug"
      :current-slug="currentSlug"
    />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { PhBook } from '@phosphor-icons/vue';
import { useBookStore } from '@/stores/books';
import type { Book } from '@/types/book';
import ChapterList from '@/components/ChapterList.vue';

const {
  book, journeySlug, currentSlug = '',
} = defineProps<{
  book: Book;
  journeySlug: string;
  currentSlug?: string;
}>();

const bookStore = useBookStore();

const children = computed(() =>
  book.children
    .map((s) => bookStore.getBySlug(s))
    .filter((c): c is NonNullable<typeof c> => !!c));
</script>

<style scoped>
@reference "../style.css";
.book-card {
  @apply border border-border rounded-sm px-4 py-3;
}
.book-title {
  @apply flex items-center gap-2 text-sm font-semibold text-fg no-underline
         hover:text-accent-blue transition-colors;
}
.book-meta {
  @apply text-xs text-fg-faint mt-0.5 ml-5 mb-2;
}
</style>
