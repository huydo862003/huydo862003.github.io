<template>
  <div class="flex flex-col gap-1 min-w-0 w-full">
    <!-- SINGLE REF -->
    <template v-if="single">
      <VDropdown
        :distance="6"
        placement="bottom-start"
        :arrow-overflow="false"
      >
        <span
          v-if="items.length"
          class="flex items-center gap-2 h-8 text-sm text-gray-700 cursor-pointer min-w-0 group"
        >
          <PhFileText
            :size="14"
            class="shrink-0 text-gray-400"
          />
          <span class="truncate underline underline-offset-2 decoration-gray-300 group-hover:decoration-gray-700">{{ resolveTitle(items[0]) }}</span>
        </span>
        <span
          v-else
          class="h-7 flex items-center text-sm text-gray-300 cursor-pointer hover:text-gray-500 hover:bg-gray-50 rounded px-1"
        >
          Empty
        </span>
        <template #popper>
          <PickerDropdown
            v-model:search="search"
            :selected="items"
            :filtered="filtered"
            :exact-match="exactMatch"
            :title-map="titleMap"
            :content-type="contentType"
            @select="selectSingle"
            @remove="remove"
            @add="selectSingle"
            @mounted="focusSearch"
          />
        </template>
      </VDropdown>
    </template>

    <!-- MULTI: relation (page-link style) -->
    <template v-else-if="isRelation">
      <span
        v-for="item in visibleItems"
        :key="item"
        class="flex items-center gap-2 h-8 text-sm text-gray-700 min-w-0"
      >
        <PhFileText
          :size="14"
          class="shrink-0 text-gray-400"
        />
        <span class="truncate underline underline-offset-2 decoration-gray-300">{{ resolveTitle(item) }}</span>
      </span>
      <VDropdown
        :distance="4"
        placement="bottom-start"
      >
        <span class="h-7 flex items-center text-sm text-gray-300 cursor-pointer hover:text-gray-500 hover:bg-gray-50 rounded px-1">
          {{ items.length > maxVisible ? `${items.length - maxVisible} more...` : items.length ? 'Edit...' : 'Empty' }}
        </span>
        <template #popper>
          <PickerDropdown
            v-model:search="search"
            :selected="items"
            :filtered="filtered"
            :exact-match="exactMatch"
            :title-map="titleMap"
            :content-type="contentType"
            @select="toggle"
            @remove="remove"
            @add="add"
            @mounted="focusSearch"
          />
        </template>
      </VDropdown>
    </template>

    <!-- MULTI: tags/enums (colored chips) -->
    <template v-else>
      <span
        v-for="item in visibleItems"
        :key="item"
        class="flex items-center gap-0.5 h-6 px-1.5 rounded text-sm min-w-0 w-full"
        :style="chipColor(item)"
      >
        <span class="truncate flex-1 min-w-0">{{ resolveTitle(item) }}</span>
        <button
          class="bg-transparent border-none cursor-pointer text-xs opacity-50 hover:opacity-100 p-0 shrink-0"
          style="color: inherit"
          @click="remove(item)"
        >
          x
        </button>
      </span>
      <VDropdown
        :distance="4"
        placement="bottom-start"
      >
        <span class="h-7 flex items-center text-sm text-gray-300 cursor-pointer hover:text-gray-500 hover:bg-gray-50 rounded px-1">
          {{ items.length > maxVisible ? `${items.length - maxVisible} more...` : items.length ? 'Edit...' : 'Empty' }}
        </span>
        <template #popper>
          <PickerDropdown
            v-model:search="search"
            :selected="items"
            :filtered="filtered"
            :exact-match="exactMatch"
            :title-map="titleMap"
            :content-type="contentType"
            @select="toggle"
            @remove="remove"
            @add="add"
            @mounted="focusSearch"
          />
        </template>
      </VDropdown>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue';
import { Dropdown as VDropdown } from 'floating-vue';
import { PhFileText } from '@phosphor-icons/vue';
import { httpClient } from '../services/http.client';
import PickerDropdown from './PickerDropdown.vue';

const model = defineModel<string[]>({ required: true });
const props = defineProps<{
  contentType?: string;
  enumOptions?: string[];
  maxVisible?: number;
  single?: boolean;
}>();

const isRelation = computed(() => !!props.contentType && !props.enumOptions?.length);

const search = ref('');
const searchInput = ref<HTMLInputElement>();
const options = ref<{ value: string; label: string }[]>([]);
const maxVisible = computed(() => props.maxVisible ?? 5);

const items = computed(() => model.value ?? []);
const visibleItems = computed(() => items.value.slice(0, maxVisible.value));

const titleMap = computed(() => {
  const m = new Map<string, string>();
  for (const o of options.value) m.set(o.value, o.label);
  return m;
});

function resolveTitle (slug: string) {
  return titleMap.value.get(slug) || slug.replace(/-/g, ' ');
}

const filtered = computed(() => {
  const q = search.value.toLowerCase();
  return options.value.filter((o) =>
    o.label.toLowerCase().includes(q) || o.value.toLowerCase().includes(q),
  );
});

const exactMatch = computed(() =>
  options.value.some((o) => o.value === search.value.trim() || o.label.toLowerCase() === search.value.trim().toLowerCase()),
);

function selectSingle (value: string) {
  model.value = [value];
  search.value = '';
}

function toggle (value: string) {
  if (items.value.includes(value)) remove(value);
  else add(value);
}

function add (value: string) {
  if (!items.value.includes(value)) model.value = [...items.value, value];
  search.value = '';
}

function remove (value: string) {
  model.value = items.value.filter((v) => v !== value);
}

const TAG_COLORS = [
  { bg: '#dbeafe', fg: '#1e40af' },
  { bg: '#fce7f3', fg: '#9d174d' },
  { bg: '#d1fae5', fg: '#065f46' },
  { bg: '#fef3c7', fg: '#92400e' },
  { bg: '#ede9fe', fg: '#5b21b6' },
  { bg: '#fee2e2', fg: '#991b1b' },
  { bg: '#ccfbf1', fg: '#115e59' },
  { bg: '#fae8ff', fg: '#86198f' },
  { bg: '#e0e7ff', fg: '#3730a3' },
  { bg: '#ecfccb', fg: '#3f6212' },
];

function hashStr (s: string): number {
  let h = 0;
  for (let i = 0; i < s.length; i++) h = ((h << 5) - h + s.charCodeAt(i)) | 0;
  return Math.abs(h);
}

function chipColor (value: string): Record<string, string> {
  const c = TAG_COLORS[hashStr(value) % TAG_COLORS.length];
  return { background: c.bg, color: c.fg };
}

function focusSearch () {
  // handled by PickerDropdown
}

async function loadOptions () {
  if (props.enumOptions?.length) {
    options.value = props.enumOptions.map((v) => ({ value: v, label: v }));
  } else if (props.contentType) {
    try {
      const { data } = await httpClient.get('/list', { params: { type: props.contentType } });
      options.value = data.map((d: { slug: string; title: string }) => ({ value: d.slug, label: d.title }));
    } catch { /* fallback to empty */ }
  }
}

onMounted(loadOptions);
watch(() => props.contentType, loadOptions);
watch(() => props.enumOptions, loadOptions);
</script>

<style>
.v-popper--theme-dropdown .v-popper__arrow-container {
  display: none !important;
}
.v-popper--theme-dropdown .v-popper__inner {
  border: none !important;
}
</style>
