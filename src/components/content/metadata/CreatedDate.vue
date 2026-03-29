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
@reference "../../../style.css";
@reference "../../../style.css";
.created-date {
  @apply text-xs text-fg-faint mb-4;
}
</style>
