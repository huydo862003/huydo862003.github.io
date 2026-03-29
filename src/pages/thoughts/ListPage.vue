<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        to="/"
        class="back"
      >
        &larr; home
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Thoughts', to: '/thoughts' }]" />
    </div>
    <h1>Scrambled Thoughts</h1>
    <ul class="list">
      <li
        v-for="post in posts"
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
      v-if="!posts.length"
      class="empty"
    >
      Nothing here yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useThoughtStore } from '@/stores/thoughts';

const { thoughts: posts } = useThoughtStore();
</script>

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold mb-6;
}
.list {
  @apply list-none p-0 m-0;
}
.list li {
  @apply py-1 flex gap-4 items-baseline;
}
.date {
  @apply text-xs text-fg-faint shrink-0 tabular-nums;
}
.link {
  @apply text-sm no-underline hover:underline;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
