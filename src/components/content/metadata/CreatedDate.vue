<template>
  <p
    v-if="createdAt"
    class="created-date"
  >
    Posted {{ createdAt }}
  </p>
</template>

<script setup lang="ts">
defineProps<{
  createdAt: string;
}>();
</script>

<style scoped>
@reference "@/style.css";
.created-date {
  @apply text-xs mb-4;
  color: var(--gui-neutral-solid);
}
</style>
