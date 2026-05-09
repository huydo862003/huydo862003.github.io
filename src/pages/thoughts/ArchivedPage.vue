<template>
  <div class="page">
    <div class="top-bar">
      <RouterLink
        to="/thoughts"
        class="back"
      >
        &larr; all thoughts
      </RouterLink>
      <JourneyBreadcrumb
        :crumbs="[
          {
            label: 'Thoughts',
            to: '/thoughts',
          },
          {
            label: 'Archived',
            to: '/archived',
          },
        ]"
      />
    </div>
    <h1 class="text-xl font-bold mb-1">
      Archived
    </h1>
    <p class="archived-desc text-sm mb-6">
      Unlisted posts. You found the hidden section.
    </p>
    <ul class="list-none p-0 m-0">
      <li
        v-for="post in archivedPosts"
        :key="post.slug"
        class="py-1 flex gap-4 items-baseline"
      >
        <span class="archived-date text-xs shrink-0 tabular-nums">{{ post.date }}</span>
        <RouterLink
          :to="`/thoughts/${post.slug}`"
          class="text-sm no-underline hover:underline"
        >
          {{ post.title }}
        </RouterLink>
      </li>
    </ul>
    <p
      v-if="!archivedPosts.length"
      class="archived-empty text-sm"
    >
      Nothing archived yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useThoughtStore,
} from '@/stores/thoughts';

const {
  archivedThoughts: archivedPosts,
} = useThoughtStore();
</script>

<style scoped>
.archived-desc { color: var(--gui-neutral-solid); }
.archived-date { color: var(--gui-neutral-solid); }
.archived-empty { color: var(--gui-neutral-solid); }
</style>
