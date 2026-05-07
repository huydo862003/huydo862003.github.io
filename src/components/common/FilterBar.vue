<template>
  <div class="flex items-center gap-2 overflow-hidden flex-nowrap">
    <div class="shrink-0 inline-flex">
      <GDropdown
        :distance="4"
        placement="bottom-start"
      >
        <button
          class="filter-btn flex items-center gap-2 text-xs px-2 py-0.5 border rounded-sm
                 cursor-pointer transition-colors shrink-0 whitespace-nowrap w-32"
          :class="{ 'filter-btn-active': hasActive }"
        >
          <GIcon
            :name="GIconName.Filter"
            :size="10"
          />
          <span>{{ hasActive ? plural(totalActive, 'filter') : (placeholder ?? 'Filter') }}</span>
          <GIcon
            :name="GIconName.ChevronDown"
            :size="10"
            class="ml-auto shrink-0"
          />
        </button>
        <template #popper>
          <div class="menu">
            <template
              v-for="(group, groupIndex) in groups"
              :key="groupIndex"
            >
              <div
                v-if="groupIndex > 0"
                class="sep"
              />
              <button
                v-for="option in group"
                :key="option.value"
                class="item"
                :class="[option.colorClass, { active: isSelected(groupIndex, option.value) }]"
                @click="toggle(groupIndex, option.value)"
              >
                <span
                  class="check"
                  :class="{ visible: isSelected(groupIndex, option.value) }"
                >✓</span>
                {{ option.label }}
              </button>
            </template>
          </div>
        </template>
      </GDropdown>
    </div>

    <div
      v-if="hasActive"
      class="flex items-center gap-1 overflow-hidden"
    >
      <span
        v-for="chip in activeChips"
        :key="`${chip.groupIndex}-${chip.value}`"
        class="chip flex items-center gap-1 border rounded-sm px-1.5 shrink-0"
        :class="chip.colorClass"
        style="font-size: 0.625rem; line-height: 1.25rem;"
      >
        {{ chip.label }}
        <button
          class="chip-remove cursor-pointer transition-colors"
          style="font-size: 0.75rem; line-height: 1; background: none; border: none; padding: 0;"
          @click="toggle(chip.groupIndex, chip.value)"
        >*</button>
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  GIcon, GIconName, GDropdown,
} from '@hdnax/genuix';
import {
  plural,
} from '@/utils/format';

export interface FilterOption {
  label: string;
  value: string;
  colorClass?: string;
}

const props = defineProps<{
  groups: FilterOption[][];
  modelValues: string[][];
  placeholder?: string;
}>();

const emit = defineEmits<{
  'update:modelValues': [values: string[][]];
}>();

const hasActive = computed(() => props.modelValues.some((group) => 0 < group.length));
const totalActive = computed(() => props.modelValues.reduce((sum, group) => sum + group.length, 0));

const activeChips = computed(() => {
  const chips: {
    groupIndex: number;
    value: string;
    label: string;
    colorClass?: string;
  }[] = [];
  for (let groupIndex = 0; groupIndex < props.groups.length; groupIndex++) {
    for (const value of props.modelValues[groupIndex] ?? []) {
      const option = props.groups[groupIndex].find((opt) => opt.value === value);
      if (option) chips.push({
        groupIndex,
        value,
        label: option.label,
        colorClass: option.colorClass,
      });
    }
  }
  return chips;
});

function isSelected (groupIndex: number, value: string): boolean {
  return props.modelValues[groupIndex]?.includes(value) ?? false;
}

function toggle (groupIndex: number, value: string) {
  const next = props.modelValues.map((group) => [...group]);
  const group = next[groupIndex] ?? [];
  const index = group.indexOf(value);
  if (0 <= index) {
    group.splice(index, 1);
  } else {
    group.push(value);
  }
  next[groupIndex] = group;
  emit('update:modelValues', next);
}
</script>

<style>
@reference "@/style.css";
.filter-btn {
  border-color: var(--gui-neutral-border);
  color: var(--gui-neutral-solid);
}
.filter-btn:hover {
  border-color: var(--gui-neutral-solid);
  color: var(--gui-neutral-fg);
}
.filter-btn-active {
  border-color: color-mix(in oklch, var(--gui-neutral-solid) 60%, transparent);
  color: var(--gui-neutral-fg);
}
.chip {
  color: var(--gui-neutral-solid);
  border-color: var(--gui-neutral-border);
}
.chip-remove {
  color: color-mix(in oklch, var(--gui-neutral-solid) 60%, transparent);
}
.chip-remove:hover {
  color: var(--gui-neutral-fg);
}
.v-popper--theme-dropdown .v-popper__inner {
  background: var(--gui-neutral-bg) !important;
  color: var(--gui-neutral-fg) !important;
  border: 1px solid var(--gui-neutral-border) !important;
  border-radius: var(--radius-sm) !important;
  box-shadow: 0 2px 8px color-mix(in oklch, var(--gui-neutral-fg) 6%, transparent) !important;
  padding: 4px 0 !important;
  overflow: hidden;
}
.v-popper--theme-dropdown .v-popper__arrow-outer {
  border-color: var(--gui-neutral-border) !important;
}
.v-popper--theme-dropdown .v-popper__arrow-inner {
  border-color: var(--gui-neutral-bg) !important;
}
.menu {
  display: flex;
  flex-direction: column;
  min-width: 120px;
}
.item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 5px 12px;
  font-size: 12px;
  text-align: left;
  cursor: pointer;
  border: none;
  background: none;
  color: var(--gui-neutral-fg-muted);
  transition: background 0.1s;
  width: 100%;
}
.item:hover {
  background: var(--gui-neutral-bg-subtle);
  color: var(--gui-neutral-fg);
}
.item.active { color: var(--gui-neutral-fg); font-weight: 500; }
.item.book.active { color: var(--gui-info-solid); }
.item.post.active { color: var(--gui-success-solid); }
.item.paper.active { color: var(--gui-warning-solid); }
.check {
  font-size: 10px;
  width: 10px;
  opacity: 0;
  color: var(--gui-neutral-fg-muted);
}
.check.visible { opacity: 1; }
.sep {
  border-top: 1px solid var(--gui-neutral-border);
  margin: 4px 0;
}
</style>
