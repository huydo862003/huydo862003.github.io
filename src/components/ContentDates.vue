<template>
  <p
    v-if="createdAt || updatedAt"
    class="dates"
  >
    <span v-if="createdAt">Posted {{ createdAt }}</span>
    <span v-if="createdAt && updatedAt && createdAt !== updatedAt"> · </span>
    <span v-if="updatedAt && createdAt !== updatedAt">Updated {{ updatedAt }}</span>
  </p>
</template>

<script setup lang="ts">
defineProps<{
  createdAt?: string;
  updatedAt?: string;
}>();
</script>

<style scoped>
@reference "../style.css";
.dates {
  @apply text-xs text-fg-faint mb-4;
}
</style>
