<template>
  <div class="page">
    <div class="top-bar">
      <RouterLink
        to="/"
        class="back"
      >
        &larr; home
      </RouterLink>
      <JourneyBreadcrumb
        :crumbs="[
          {
            label: 'Thoughts',
            to: '/thoughts',
          },
        ]"
      />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Scrambled Thoughts
    </h1>
    <ul class="list-none p-0 m-0">
      <li
        v-for="post in posts"
        :key="post.slug"
        class="py-1 flex gap-4 items-baseline"
      >
        <span class="thoughts-date text-xs shrink-0 tabular-nums">{{ post.date }}</span>
        <RouterLink
          :to="`/thoughts/${post.slug}`"
          class="text-sm no-underline hover:underline"
        >
          {{ post.title }}
        </RouterLink>
      </li>
    </ul>
    <p
      v-if="!posts.length"
      class="thoughts-empty text-sm"
    >
      Nothing here yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  ref,
} from 'vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useThoughtStore,
} from '@/stores/thoughts';
import {
  useSeo,
} from '@/composables/useSeo';

useSeo({
  title: ref('Scrambled Thoughts'),
  description: ref('All thoughts, notes, and write-ups from Scrambled Kitchen.'),
  path: ref('/thoughts'),
  type: 'website',
});

const {
  thoughts: posts,
} = useThoughtStore();
</script>

<style scoped>
.thoughts-date { color: var(--gui-neutral-solid); }
.thoughts-empty { color: var(--gui-neutral-solid); }
</style>
