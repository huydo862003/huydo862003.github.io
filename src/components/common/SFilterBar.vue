<template>
  <div class="filterbar">
    <div class="dropdown-anchor">
      <SDropdown>
        <template #trigger>
          <button
            class="trigger"
            :class="{ active: hasActive }"
          >
            <PhFunnel :size="10" />
            <span class="trigger-label">{{ hasActive ? plural(totalActive, 'filter') : (placeholder ?? 'Filter') }}</span>
            <PhCaretDown
              :size="10"
              class="caret"
            />
          </button>
        </template>
        <template #default>
          <template
            v-for="(group, gi) in groups"
            :key="gi"
          >
            <div
              v-if="gi > 0"
              class="sep"
            />
            <button
              v-for="opt in group"
              :key="opt.value"
              class="item"
              :class="[opt.colorClass, { active: isSelected(gi, opt.value) }]"
              @click="toggle(gi, opt.value)"
            >
              <span
                class="check"
                :class="{ visible: isSelected(gi, opt.value) }"
              >✓</span>
              {{ opt.label }}
            </button>
          </template>
        </template>
      </SDropdown>
    </div>

    <div
      v-if="hasActive"
      class="chips"
    >
      <span
        v-for="chip in activeChips"
        :key="`${chip.gi}-${chip.value}`"
        class="chip"
        :class="chip.colorClass"
      >
        {{ chip.label }}
        <button
          class="chip-remove"
          @click="toggle(chip.gi, chip.value)"
        >×</button>
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  PhCaretDown, PhFunnel,
} from '@phosphor-icons/vue';
import SDropdown from './SDropdown.vue';
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

const hasActive = computed(() => props.modelValues.some((g) => 0 < g.length));
const totalActive = computed(() => props.modelValues.reduce((sum, g) => sum + g.length, 0));

const activeChips = computed(() => {
  const chips: { gi: number;
    value: string;
    label: string;
    colorClass?: string; }[] = [];
  for (let gi = 0; gi < props.groups.length; gi++) {
    for (const value of props.modelValues[gi] ?? []) {
      const opt = props.groups[gi].find((o) => o.value === value);
      if (opt) chips.push({
        gi,
        value,
        label: opt.label,
        colorClass: opt.colorClass,
      });
    }
  }
  return chips;
});

function isSelected (gi: number, value: string): boolean {
  return props.modelValues[gi]?.includes(value) ?? false;
}

function toggle (gi: number, value: string) {
  const next = props.modelValues.map((g) => [...g]);
  const group = next[gi] ?? [];
  const idx = group.indexOf(value);
  if (0 <= idx) {
    group.splice(idx, 1);
  } else {
    group.push(value);
  }
  next[gi] = group;
  emit('update:modelValues', next);
}
</script>

<style scoped>
@reference "../../style.css";
.filterbar {
  @apply flex items-center gap-2 overflow-hidden flex-nowrap;
}
.dropdown-anchor {
  @apply shrink-0 inline-flex;
}
.trigger {
  @apply flex items-center gap-2 text-xs px-2 py-0.5 border border-border rounded-sm
         text-fg-faint cursor-pointer hover:border-fg-faint hover:text-fg transition-colors shrink-0
         whitespace-nowrap;
  width: 8rem;
}
.caret {
  @apply ml-auto shrink-0;
}
.trigger.active {
  @apply border-fg-faint/60 text-fg;
}
.chips {
  @apply flex items-center gap-1 overflow-hidden;
}
.chip {
  @apply flex items-center gap-1 text-fg-faint border border-border rounded-sm px-1.5 shrink-0;
  font-size: 0.625rem;
  line-height: 1.25rem;
}
.chip.book { @apply text-accent-blue border-accent-blue/30; }
.chip.post { @apply text-accent-green border-accent-green/30; }
.chip.paper { @apply text-accent-yellow border-accent-yellow/30; }
.chip-remove {
  @apply cursor-pointer text-fg-faint/60 hover:text-fg transition-colors;
  font-size: 0.75rem;
  line-height: 1;
  background: none;
  border: none;
  padding: 0;
}
.sep {
  @apply border-t border-border mx-0 my-1;
}
</style>

<style>
@reference "../../style.css";
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
  color: var(--color-fg-muted);
  transition: background 0.1s;
  width: 100%;
}
.item:hover {
  background: var(--color-bg-subtle);
  color: var(--color-fg);
}
.item.active { color: var(--color-fg); font-weight: 500; }
.item.book.active { color: var(--color-accent-blue); }
.item.post.active { color: var(--color-accent-green); }
.item.paper.active { color: var(--color-accent-yellow); }
.check {
  font-size: 10px;
  width: 10px;
  opacity: 0;
  color: var(--color-fg-faint);
}
.check.visible { opacity: 1; }
</style>
