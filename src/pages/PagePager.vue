<template>
  <div class="pager">
    <button
      :disabled="modelValue <= 1"
      class="pager-btn"
      @click="$emit('update:modelValue', modelValue - 1)"
    >
      &larr;
    </button>
    <span class="pager-info">{{ modelValue }} / {{ total }}</span>
    <button
      :disabled="modelValue >= total"
      class="pager-btn"
      @click="$emit('update:modelValue', modelValue + 1)"
    >
      &rarr;
    </button>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  modelValue: number;
  total: number;
}>();

defineEmits<{
  'update:modelValue': [page: number];
}>();
</script>

<style scoped>
@reference "@/style.css";
.pager {
  @apply flex items-center justify-center gap-3;
}
.pager-btn {
  @apply text-sm px-2 py-1 border rounded-sm transition-colors cursor-pointer
         disabled:opacity-30 disabled:cursor-default;
  border-color: var(--gui-neutral-border);
  color: var(--gui-neutral-fg-muted);
  &:hover { border-color: var(--gui-neutral-solid); }
}
.pager-info {
  @apply text-xs;
  color: var(--gui-neutral-solid);
}
</style>
