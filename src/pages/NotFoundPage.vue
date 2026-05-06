<template>
  <div class="page center">
    <span class="big-404">404</span>
    <p class="msg">
      This page got too scrambled and fell off the plate.
    </p>
    <div class="top-bar">
      <router-link
        to="/"
        class="back"
      >
        &larr; back to the kitchen
      </router-link>
    </div>
  </div>
</template>

<style scoped>
@reference "@/style.css";
.center {
  @apply flex flex-col items-center justify-center min-h-[60vh];
}
.big-404 {
  @apply text-8xl font-bold leading-none;
  color: color-mix(in oklch, var(--gui-neutral-solid) 20%, transparent);
}
.msg {
  @apply text-sm mb-4 mt-2;
  color: var(--gui-neutral-fg-muted);
}
</style>
