<template>
  <span class="kbd-group">
    <template
      v-for="(key, i) in keys"
      :key="i"
    >
      <span
        v-if="i > 0"
        class="kbd-sep"
      >+</span>
      <kbd class="kbd">{{ key }}</kbd>
    </template>
  </span>
</template>

<script setup lang="ts">
defineProps<{
  keys: string[];
}>();
</script>

<style scoped>
@reference "../style.css";
.kbd-group {
  @apply inline-flex items-center gap-1;
}
.kbd {
  @apply inline-flex items-center justify-center min-w-5 h-5 px-1
         text-xs text-fg-faint bg-bg-subtle border border-border
         rounded-sm font-mono leading-none;
}
.kbd-sep {
  @apply text-xs text-fg-faint/40;
}
</style>
