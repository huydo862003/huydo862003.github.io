<template>
  <VDropdown :distance="6">
    <button class="dropdown-trigger">
      <span>{{ displayLabel }}</span>
      <PhCaretDown :size="12" />
    </button>
    <template #popper="{ hide }">
      <div class="dropdown-menu">
        <button
          v-for="opt in options"
          :key="opt.value"
          class="dropdown-item"
          :class="{ active: modelValue === opt.value }"
          @click="$emit('update:modelValue', opt.value); hide()"
        >
          {{ opt.label }}
        </button>
      </div>
    </template>
  </VDropdown>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { Dropdown as VDropdown } from 'floating-vue';
import { PhCaretDown } from '@phosphor-icons/vue';

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
@reference "../style.css";
.dropdown-trigger {
  @apply flex items-center gap-1.5 text-xs px-2.5 py-1 border border-border rounded-sm
         text-fg-muted hover:border-fg-faint transition-colors cursor-pointer;
}
</style>

<style>
.dropdown-menu {
  display: flex;
  flex-direction: column;
  min-width: 140px;
}
.dropdown-item {
  padding: 6px 12px;
  font-size: 13px;
  text-align: left;
  cursor: pointer;
  border: none;
  background: none;
  color: var(--color-fg-muted);
  transition: background 0.1s;
}
.dropdown-item:hover {
  background: var(--color-bg-subtle);
  color: var(--color-fg);
}
.dropdown-item.active {
  color: var(--color-fg);
  font-weight: 600;
}
.v-popper--theme-dropdown .v-popper__inner {
  background: var(--color-bg) !important;
  color: var(--color-fg) !important;
  border: 1px solid var(--color-border) !important;
  border-radius: 6px !important;
  box-shadow: 0 4px 16px color-mix(in oklch, var(--color-fg) 15%, transparent) !important;
  padding: 4px 0 !important;
  overflow: hidden;
}
.v-popper--theme-dropdown .v-popper__arrow-outer {
  border-color: var(--color-border) !important;
}
.v-popper--theme-dropdown .v-popper__arrow-inner {
  border-color: var(--color-bg) !important;
}
</style>
