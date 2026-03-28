<template>
  <ul :class="depth === 0 ? 'chapters' : 'sub-chapters'">
    <li
      v-for="ch in chapters"
      :key="ch.slug"
    >
      <div class="chapter-row">
        <router-link
          :to="`/journeys/${journeySlug}/books/${ch.slug}`"
          :class="['chapter-link', { active: ch.slug === currentSlug }]"
        >
          {{ ch.title }}
        </router-link>
        <span
          v-if="ch.concepts.length"
          class="chapter-meta"
        >{{ ch.concepts.length }} concepts</span>
      </div>
      <ChapterList
        v-if="grandchildren(ch).length"
        :chapters="grandchildren(ch)"
        :journey-slug="journeySlug"
        :depth="depth + 1"
        :current-slug="currentSlug"
      />
    </li>
  </ul>
</template>

<script setup lang="ts">
import { useBookStore } from '@/stores/books';
import type { Book } from '@/types/book';

const {
  chapters, journeySlug, depth = 0, currentSlug = '',
} = defineProps<{
  chapters: Book[];
  journeySlug: string;
  depth?: number;
  currentSlug?: string;
}>();

const bookStore = useBookStore();

function grandchildren (ch: Book): Book[] {
  return ch.children
    .map((s) => bookStore.getBySlug(s))
    .filter((c): c is NonNullable<typeof c> => !!c);
}
</script>

<style scoped>
@reference "../style.css";
.chapters {
  @apply list-none p-0 m-0 flex flex-col gap-0.5;
}
.chapters > li {
  @apply border-l-2 border-border pl-3 py-1.5;
}
.sub-chapters {
  @apply list-none p-0 m-0 ml-2 mt-1 flex flex-col gap-0.5;
}
.sub-chapters > li {
  @apply border-l border-border/50 pl-3 py-1;
}
.chapter-row {
  @apply flex items-center justify-between gap-2;
}
.chapter-link {
  @apply text-xs text-fg-muted no-underline hover:text-accent-blue transition-colors;
}
.chapter-link.active {
  @apply text-fg font-semibold;
}
.chapter-meta {
  @apply text-xs text-fg-faint shrink-0 hidden sm:inline;
}
</style>
