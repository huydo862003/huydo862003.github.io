<template>
  <div class="page flex flex-col items-center justify-center min-h-[60vh]">
    <span class="notfound-code text-8xl font-bold leading-none">404</span>
    <p class="notfound-message text-sm mb-4 mt-2">
      This page got too scrambled and fell off the plate.
    </p>
    <div class="top-bar">
      <RouterLink
        to="/"
        class="back"
      >
        &larr; back to the kitchen
      </RouterLink>
    </div>
  </div>
</template>

<style scoped>
.notfound-code {
  color: color-mix(in oklch, var(--gui-neutral-solid) 20%, transparent);
}
.notfound-message {
  color: var(--gui-neutral-fg-muted);
}
</style>
