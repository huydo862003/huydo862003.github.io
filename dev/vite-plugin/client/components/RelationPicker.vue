<template>
  <div class="flex flex-col gap-1 min-w-0 w-full">
    <!-- SINGLE REF -->
    <template v-if="single">
      <Dropdown
        :distance="6"
        placement="bottom-start"
        :arrow-overflow="false"
      >
        <span
          v-if="items.length"
          class="flex items-center gap-2 h-8 text-sm text-gray-700 cursor-pointer min-w-0 group"
        >
          <GIcon
            :name="GIconName.File"
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
      </Dropdown>
    </template>

    <!-- MULTI: relation (page-link style) -->
    <template v-else-if="isRelation">
      <span
        v-for="item in visibleItems"
        :key="item"
        class="flex items-center gap-2 h-8 text-sm text-gray-700 min-w-0"
      >
        <GIcon
          :name="GIconName.File"
          :size="14"
          class="shrink-0 text-gray-400"
        />
        <span class="truncate underline underline-offset-2 decoration-gray-300">{{ resolveTitle(item) }}</span>
      </span>
      <Dropdown
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
      </Dropdown>
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
          @click="() => remove(item)"
        >
          x
        </button>
      </span>
      <Dropdown
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
      </Dropdown>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, onMounted, watch,
} from 'vue';
import {
  Dropdown,
} from 'floating-vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  httpClient,
} from '../services/http.client';
import PickerDropdown from './PickerDropdown.vue';

const model = defineModel<string[]>({
  required: true,
});
const props = defineProps<{
  contentType?: string;
  enumOptions?: string[];
  maxVisible?: number;
  single?: boolean;
}>();

const isRelation = computed(() => !!props.contentType && !props.enumOptions?.length);

const search = ref('');
const options = ref<{
  value: string;
  label: string;
}[]>([]);
const maxVisible = computed(() => props.maxVisible ?? 5);

const items = computed(() => model.value ?? []);
const visibleItems = computed(() => items.value.slice(0, maxVisible.value));

const titleMap = computed(() => {
  const labelMap = new Map<string, string>();

  for (const option of options.value) labelMap.set(option.value, option.label);

  return labelMap;
});

function resolveTitle (slug: string) {
  return titleMap.value.get(slug) || slug.replace(/-/g, ' ');
}

const filtered = computed(() => {
  const searchQuery = search.value.toLowerCase();

  return options.value.filter((option) =>
    option.label.toLowerCase().includes(searchQuery) || option.value.toLowerCase().includes(searchQuery));
});

const exactMatch = computed(() =>
  options.value.some((option) => option.value === search.value.trim() || option.label.toLowerCase() === search.value.trim().toLowerCase()));

function add (value: string) {
  if (!items.value.includes(value)) model.value = [
    ...items.value,
    value,
  ];
  search.value = '';
}

function remove (value: string) {
  model.value = items.value.filter((item) => item !== value);
}

function selectSingle (value: string) {
  model.value = [value];
  search.value = '';
}

function toggle (value: string) {
  if (items.value.includes(value)) remove(value);
  else add(value);
}

const TAG_COLORS = [
  {
    bg: '#dbeafe',
    fg: '#1e40af',
  },
  {
    bg: '#fce7f3',
    fg: '#9d174d',
  },
  {
    bg: '#d1fae5',
    fg: '#065f46',
  },
  {
    bg: '#fef3c7',
    fg: '#92400e',
  },
  {
    bg: '#ede9fe',
    fg: '#5b21b6',
  },
  {
    bg: '#fee2e2',
    fg: '#991b1b',
  },
  {
    bg: '#ccfbf1',
    fg: '#115e59',
  },
  {
    bg: '#fae8ff',
    fg: '#86198f',
  },
  {
    bg: '#e0e7ff',
    fg: '#3730a3',
  },
  {
    bg: '#ecfccb',
    fg: '#3f6212',
  },
];

function chipColor (value: string): Record<string, string> {
  const tagColor = TAG_COLORS[hashString(value) % TAG_COLORS.length];

  return {
    background: tagColor.bg,
    color: tagColor.fg,
  };
}

function focusSearch () {
  // handled by PickerDropdown
}

function hashString (slug: string): number {
  let hashCode = 0;

  for (let index = 0; index < slug.length; index++) hashCode = ((hashCode << 5) - hashCode + slug.charCodeAt(index)) | 0;

  return Math.abs(hashCode);
}

async function loadOptions () {
  if (props.enumOptions?.length) {
    options.value = props.enumOptions.map((value) => ({
      value: value,
      label: value,
    }));
  } else if (props.contentType) {
    try {
      const {
        data,
      } = await httpClient.get('/list', {
        params: {
          type: props.contentType,
        },
      });

      options.value = data.map((definition: {
        slug: string;
        title: string;
      }) => ({
        value: definition.slug,
        label: definition.title,
      }));
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
