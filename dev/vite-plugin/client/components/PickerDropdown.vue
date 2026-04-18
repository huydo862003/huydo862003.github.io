<template>
  <div class="flex flex-col w-96 max-h-80 bg-white rounded-lg shadow-lg">
    <!-- search -->
    <div class="flex items-center border-b border-gray-100 px-3">
      <input
        ref="searchEl"
        :value="search"
        class="flex-1 py-2.5 text-sm border-none outline-none bg-transparent"
        :placeholder="contentType ? `Search linked pages...` : 'Search...'"
        @input="$emit('update:search', ($event.target as HTMLInputElement).value)"
        @vue:mounted="$emit('mounted')"
      >
      <span
        v-if="contentType"
        class="text-xs text-gray-400 shrink-0"
      >
        In <span class="font-medium text-gray-600">{{ contentType }}</span>
      </span>
    </div>

    <div class="overflow-y-auto flex-1">
      <!-- selected items -->
      <div v-if="selected.length">
        <div class="px-3 pt-2 pb-1 text-xs text-gray-400">
          {{ selected.length }} selected
        </div>
        <button
          v-for="item in selected"
          :key="item"
          class="flex items-center justify-between w-full px-3 py-2 text-sm text-left border-none bg-gray-50 cursor-pointer hover:bg-gray-100"
          @click="$emit('remove', item)"
        >
          <span class="flex items-center gap-2 truncate min-w-0">
            <PhFileText
              :size="14"
              class="shrink-0 text-gray-400"
            />
            <span class="truncate">{{ resolve(item) }}</span>
          </span>
          <PhMinus
            :size="14"
            class="shrink-0 text-gray-400"
          />
        </button>
      </div>

      <!-- divider -->
      <div
        v-if="selected.length && unselected.length"
        class="border-b border-gray-100"
      />

      <!-- unselected / available -->
      <div v-if="unselected.length || (search && !exactMatch)">
        <div
          v-if="selected.length"
          class="px-3 pt-2 pb-1 text-xs text-gray-400"
        >
          Select more
        </div>
        <button
          v-for="opt in unselected"
          :key="opt.value"
          class="flex items-center gap-2 w-full px-3 py-2 text-sm text-left border-none bg-transparent cursor-pointer hover:bg-gray-50"
          @click="$emit('select', opt.value)"
        >
          <PhFileText
            :size="14"
            class="shrink-0 text-gray-400"
          />
          <span class="truncate">{{ opt.label }}</span>
        </button>
        <button
          v-if="search && !exactMatch"
          class="flex items-center gap-2 w-full px-3 py-2 text-sm text-blue-600 font-medium text-left border-none bg-blue-50 cursor-pointer hover:bg-blue-100 rounded"
          @click="$emit('add', search.trim())"
        >
          + Add "{{ search.trim() }}"
        </button>
      </div>

      <!-- empty: only show when search yields no results -->
      <div
        v-if="search && !filtered.length && !selected.length"
        class="p-4 text-sm text-gray-400 text-center"
      >
        No options
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { PhFileText, PhMinus } from '@phosphor-icons/vue';

const props = defineProps<{
  search: string;
  selected: string[];
  filtered: { value: string; label: string }[];
  exactMatch: boolean;
  titleMap: Map<string, string>;
  contentType?: string;
}>();

defineEmits<{
  'update:search': [value: string];
  select: [value: string];
  remove: [value: string];
  add: [value: string];
  mounted: [];
}>();

const searchEl = ref<HTMLInputElement>();

const unselected = computed(() =>
  props.filtered.filter((o) => !props.selected.includes(o.value)),
);

function resolve (slug: string) {
  return props.titleMap.get(slug) || slug.replace(/-/g, ' ');
}
</script>
