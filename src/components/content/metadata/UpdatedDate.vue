<template>
  <p
    v-if="updatedAt"
    class="updated-date"
  >
    Updated {{ updatedAt }}
  </p>
</template>

<script setup lang="ts">
defineProps<{
  updatedAt: string;
}>();
</script>

<style scoped>
@reference "../../../style.css";
@reference "../../../style.css";
.updated-date {
  @apply text-xs text-fg-faint;
}
</style>
