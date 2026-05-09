<template>
  <nav
    v-if="previous || next"
    class="pagination-nav flex justify-between gap-4 mt-10 mb-4 pt-6"
  >
    <RouterLink
      v-if="previous"
      :to="previous.to"
      class="pagination-link pagination-link-prev flex flex-col no-underline"
    >
      <span class="pagination-nav-label text-xs">&larr; Previous {{ kind }}</span>
      <span class="pagination-title text-sm transition-colors line-clamp-2">{{ previous.title }}</span>
    </RouterLink>
    <div v-else />
    <RouterLink
      v-if="next"
      key="router-link-2"
      :to="next.to"
      class="pagination-link pagination-link-next flex flex-col items-end text-right no-underline ml-auto"
    >
      <span class="pagination-nav-label text-xs">Next {{ kind }} &rarr;</span>
      <span class="pagination-title text-sm transition-colors line-clamp-2">{{ next.title }}</span>
    </RouterLink>
  </nav>
</template>

<script setup lang="ts">
export interface NavItem {
  to: string;
  title: string;
}

const {
  prev: previous = undefined,
  next = undefined,
  kind = '',
} = defineProps<{
  /** The previous item to navigate to */
  prev?: NavItem;
  /** The next item to navigate to */
  next?: NavItem;
  /** The kind label shown next to arrows */
  kind?: string;
}>();
</script>

<style scoped>
.pagination-nav {
  border-top: 1px solid var(--gui-neutral-border);
}
.pagination-link-prev,
.pagination-link-next {
  max-width: 45%;
}
.pagination-nav-label {
  color: var(--gui-neutral-solid);
  margin-bottom: 0.125rem;
}
.pagination-title {
  color: var(--gui-neutral-fg-muted);
}
.pagination-link:hover .pagination-title {
  color: var(--gui-info-solid);
}
</style>
