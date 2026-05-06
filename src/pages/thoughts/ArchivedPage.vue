<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        to="/thoughts"
        class="back"
      >
        &larr; all thoughts
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Thoughts', to: '/thoughts' }, { label: 'Archived', to: '/archived' }]" />
    </div>
    <h1>Archived</h1>
    <p class="subtitle">
      Unlisted posts. You found the hidden section.
    </p>
    <ul class="list">
      <li
        v-for="post in archivedPosts"
        :key="post.slug"
      >
        <span class="date">{{ post.date }}</span>
        <router-link
          :to="`/thoughts/${post.slug}`"
          class="link"
        >
          {{ post.title }}
        </router-link>
      </li>
    </ul>
    <p
      v-if="!archivedPosts.length"
      class="empty"
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
@reference "@/style.css";
h1 {
  @apply text-xl font-bold mb-1;
}
.subtitle {
  @apply text-sm mb-6;
  color: var(--gui-neutral-solid);
}
.list {
  @apply list-none p-0 m-0;
}
.list li {
  @apply py-1 flex gap-4 items-baseline;
}
.date {
  @apply text-xs shrink-0 tabular-nums;
  color: var(--gui-neutral-solid);
}
.link {
  @apply text-sm no-underline hover:underline;
}
.empty {
  @apply text-sm;
  color: var(--gui-neutral-solid);
}
</style>
