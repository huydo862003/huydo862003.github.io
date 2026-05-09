<template>
  <footer class="footer-bar h-12 flex items-center justify-center gap-2 border-t border-b text-xs shrink-0">
    <span>&copy; {{ year }} Scrambled Kitchen</span>
    <span>&middot;</span>
    <a
      href="https://github.com/huydo862003"
      target="_blank"
      rel="noopener noreferrer"
      class="foot-link no-underline"
    >GitHub</a>
  </footer>
</template>

<script setup lang="ts">
const year = new Date().getFullYear();
</script>

<style scoped>
.footer-bar {
  border-color: var(--gui-neutral-border);
  color: var(--gui-neutral-fg-muted);
  background: var(--gui-neutral-bg-subtle);
}
.foot-link {
  color: var(--gui-neutral-fg-muted);
}
.foot-link:hover { color: var(--gui-neutral-fg); }
</style>
