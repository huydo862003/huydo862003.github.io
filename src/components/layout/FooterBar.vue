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
@reference "@/style.css";

.foot {
  @apply h-12 flex items-center justify-center gap-2 border-t border-b text-xs shrink-0;
  border-color: var(--gui-neutral-border);
  color: var(--gui-neutral-fg-muted);
  background: var(--gui-neutral-bg-subtle);
}
.foot a {
  @apply no-underline;
  color: var(--gui-neutral-fg-muted);
  &:hover { color: var(--gui-neutral-fg); }
}
</style>
