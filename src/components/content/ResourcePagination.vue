<template>
  <nav
    v-if="prev || next"
    class="pagination-nav"
  >
    <router-link
      v-if="prev"
      :to="prev.to"
      class="pagination-link"
    >
      <span class="pagination-dir">&larr; Previous {{ kind }}</span>
      <span class="pagination-title">{{ prev.title }}</span>
    </router-link>
    <div v-else />
    <router-link
      v-if="next"
      :to="next.to"
      class="pagination-link pagination-link-next"
    >
      <span class="pagination-dir">Next {{ kind }} &rarr;</span>
      <span class="pagination-title">{{ next.title }}</span>
    </router-link>
  </nav>
</template>

<script setup lang="ts">
export interface NavItem {
  to: string;
  title: string;
}

const {
  prev, next, kind = '',
} = defineProps<{
  prev?: NavItem;
  next?: NavItem;
  kind?: string;
}>();
</script>

<style>
.pagination-nav {
  display: flex;
  justify-content: space-between;
  gap: 1rem;
  margin-top: 2.5rem;
  margin-bottom: 1rem;
  padding-top: 1.5rem;
  border-top: 1px solid var(--gui-neutral-border);
}
.pagination-link {
  display: flex;
  flex-direction: column;
  text-decoration: none;
  max-width: 45%;
}
.pagination-link-next {
  align-items: flex-end;
  text-align: right;
  margin-left: auto;
}
.pagination-dir {
  font-size: 0.75rem;
  color: var(--gui-neutral-solid);
  margin-bottom: 0.125rem;
}
.pagination-title {
  font-size: 0.875rem;
  color: var(--gui-neutral-fg-muted);
  transition: color 0.15s;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.pagination-link:hover .pagination-title {
  color: var(--gui-info-solid);
}
</style>
