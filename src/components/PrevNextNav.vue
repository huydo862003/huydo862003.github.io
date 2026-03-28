<template>
  <nav
    v-if="prev || next"
    class="prev-next-nav"
  >
    <router-link
      v-if="prev"
      :to="prev.to"
      class="nav-prev"
    >
      <span class="nav-label">&larr; Previous {{ kind }}</span>
      <span class="nav-title">{{ prev.title }}</span>
    </router-link>
    <div v-else />
    <router-link
      v-if="next"
      :to="next.to"
      class="nav-next"
    >
      <span class="nav-label">Next {{ kind }} &rarr;</span>
      <span class="nav-title">{{ next.title }}</span>
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

<style scoped>
@reference "../style.css";
.prev-next-nav {
  @apply flex justify-between gap-4 mt-10 mb-4 pt-6 border-t border-border;
}
.nav-prev,
.nav-next {
  @apply flex flex-col no-underline max-w-[45%];
}
.nav-next {
  @apply items-end text-right ml-auto;
}
.nav-label {
  @apply text-xs text-fg-faint mb-0.5;
}
.nav-title {
  @apply text-sm text-fg-muted hover:text-accent-blue transition-colors
         line-clamp-2;
}
</style>
