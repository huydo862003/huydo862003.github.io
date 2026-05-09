<template>
  <div class="flex items-center justify-center gap-3">
    <button
      type="button"
      :disabled="modelValue <= 1"
      class="pager-btn text-sm px-2 py-1 border rounded-sm transition-colors cursor-pointer disabled:opacity-30 disabled:cursor-default"
      @click="previousPage"
    >
      &larr;
    </button>
    <span class="pager-info text-xs">{{ modelValue }} / {{ total }}</span>
    <button
      type="button"
      :disabled="modelValue >= total"
      class="pager-btn text-sm px-2 py-1 border rounded-sm transition-colors cursor-pointer disabled:opacity-30 disabled:cursor-default"
      @click="nextPage"
    >
      &rarr;
    </button>
  </div>
</template>

<script setup lang="ts">
const {
  modelValue, total,
} = defineProps<{
  /** The current page number */
  modelValue: number;
  /** The total number of pages */
  total: number;
}>();

const emit = defineEmits<{
  'update:modelValue': [page: number];
}>();

function nextPage () {
  emit('update:modelValue', modelValue + 1);
}

function previousPage () {
  emit('update:modelValue', modelValue - 1);
}
</script>

<style scoped>
.pager-btn {
  border-color: var(--gui-neutral-border);
  color: var(--gui-neutral-fg-muted);
}
.pager-info {
  color: var(--gui-neutral-solid);
}
.pager-btn:hover { border-color: var(--gui-neutral-solid); }
</style>
