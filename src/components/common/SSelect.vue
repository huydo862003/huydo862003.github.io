<template>
  <SDropdown>
    <template #trigger>
      <button class="trigger">
        <span>{{ displayLabel }}</span>
        <PhCaretDown :size="12" />
      </button>
    </template>
    <template #default="{ hide }">
      <button
        v-for="opt in options"
        :key="opt.value"
        class="item"
        :class="{ active: modelValue === opt.value }"
        @click="$emit('update:modelValue', opt.value); hide()"
      >
        {{ opt.label }}
      </button>
    </template>
  </SDropdown>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { PhCaretDown } from '@phosphor-icons/vue';
import SDropdown from './SDropdown.vue';

const props = defineProps<{
  modelValue: string;
  options: { value: string;
    label: string; }[];
  placeholder?: string;
}>();

defineEmits<{
  'update:modelValue': [value: string];
}>();

const displayLabel = computed(() => {
  const match = props.options.find((o) => o.value === props.modelValue);
  return match?.label ?? props.placeholder ?? 'Select...';
});
</script>

<style scoped>
@reference "../../style.css";
.trigger {
  @apply flex items-center gap-1.5 text-xs px-2.5 py-1 border border-border rounded-sm
         text-fg-muted hover:border-fg-faint transition-colors cursor-pointer;
}
</style>

<style>
@reference "../../style.css";
.item {
  padding: 6px 12px;
  font-size: 12px;
  text-align: left;
  cursor: pointer;
  border: none;
  background: none;
  color: var(--color-fg-muted);
  transition: background 0.1s;
}
.item:hover {
  background: var(--color-bg-subtle);
  color: var(--color-fg);
}
.item.active {
  color: var(--color-fg);
  font-weight: 600;
}
</style>
