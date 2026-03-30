<template>
  <footer class="foot">
    <span>&copy; {{ year }} Scrambled Kitchen</span>
    <span>&middot;</span>
    <a
      href="https://github.com/huydo862003"
      target="_blank"
      rel="noopener"
    >GitHub</a>
  </footer>
</template>

<script setup lang="ts">
const year = new Date().getFullYear();
</script>

<style scoped>
@reference "../../style.css";

.foot {
  @apply h-12 flex items-center justify-center gap-2 border-t border-b border-border text-xs text-fg-faint shrink-0;
  background: var(--color-bg-subtle);
}
.foot a {
  @apply text-fg-faint no-underline hover:text-fg-muted;
}
</style>
