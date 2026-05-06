<template>
  <nav
    v-if="prev || next"
    class="flex justify-between gap-4 mt-10 mb-4 pt-6 border-t border-border"
  >
    <router-link
      v-if="prev"
      :to="prev.to"
      class="flex flex-col no-underline max-w-[45%]"
    >
      <span class="text-xs text-fg-faint mb-0.5">&larr; Previous {{ kind }}</span>
      <span class="text-sm text-fg-muted hover:text-accent-blue transition-colors line-clamp-2">{{ prev.title }}</span>
    </router-link>
    <div v-else />
    <router-link
      v-if="next"
      :to="next.to"
      class="flex flex-col no-underline max-w-[45%] items-end text-right ml-auto"
    >
      <span class="text-xs text-fg-faint mb-0.5">Next {{ kind }} &rarr;</span>
      <span class="text-sm text-fg-muted hover:text-accent-blue transition-colors line-clamp-2">{{ next.title }}</span>
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
