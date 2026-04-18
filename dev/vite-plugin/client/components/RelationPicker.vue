<template>
  <div class="flex flex-col gap-0.5 min-w-0 w-full">
    <!-- SINGLE REF -->
    <template v-if="single">
      <VDropdown
        :distance="4"
        placement="bottom-start"
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
        <button
          v-else
          class="w-full h-6 flex items-center justify-center text-sm text-gray-400 border border-dashed border-gray-300 rounded cursor-pointer hover:bg-gray-50 hover:text-gray-700"
        >
          Select...
        </button>
        <template #popper>
          <div class="rp-dropdown">
            <input
              ref="searchInput"
              v-model="search"
              class="px-2 py-1.5 border-none border-b border-gray-200 text-sm outline-none"
              placeholder="Search..."
              @vue:mounted="focusSearch"
            >
            <div class="overflow-y-auto max-h-56">
              <button
                v-for="opt in filtered"
                :key="opt.value"
                class="flex items-center justify-between w-full px-2 py-1.5 text-sm text-left border-none bg-transparent cursor-pointer hover:bg-gray-100"
                :class="{ 'text-blue-500': items.includes(opt.value) }"
                @click="selectSingle(opt.value)"
              >
                <span class="truncate">{{ opt.label }}</span>
                <span
                  v-if="items.includes(opt.value)"
                  class="text-blue-500 text-xs shrink-0"
                >✓</span>
              </button>
              <button
                v-if="search.trim() && !exactMatch"
                class="flex items-center w-full px-2 py-1.5 text-sm text-blue-500 font-medium border-none bg-transparent cursor-pointer hover:bg-gray-100"
                @click="selectSingle(search.trim())"
              >
                Add "{{ search.trim() }}"
              </button>
            </div>
          </div>
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
        <span class="h-7 flex items-center text-sm text-gray-400 cursor-pointer hover:text-gray-600">
          {{ items.length > maxVisible ? `${items.length - maxVisible} more...` : items.length ? 'Edit...' : 'Empty' }}
        </span>
        <template #popper>
          <div class="rp-dropdown">
            <input
              ref="searchInput"
              v-model="search"
              class="px-2 py-1.5 border-none border-b border-gray-200 text-sm outline-none"
              placeholder="Search..."
              @vue:mounted="focusSearch"
            >
            <div class="overflow-y-auto max-h-56">
              <button
                v-for="opt in filtered"
                :key="opt.value"
                class="flex items-center justify-between w-full px-2 py-1.5 text-sm text-left border-none bg-transparent cursor-pointer hover:bg-gray-100"
                :class="{ 'text-blue-500': items.includes(opt.value) }"
                @click="toggle(opt.value)"
              >
                <span class="truncate">{{ opt.label }}</span>
                <span
                  v-if="items.includes(opt.value)"
                  class="text-blue-500 text-xs shrink-0"
                >✓</span>
              </button>
              <button
                v-if="search.trim() && !exactMatch"
                class="flex items-center w-full px-2 py-1.5 text-sm text-blue-500 font-medium border-none bg-transparent cursor-pointer hover:bg-gray-100"
                @click="add(search.trim())"
              >
                Add "{{ search.trim() }}"
              </button>
              <div
                v-if="!filtered.length && !search.trim()"
                class="p-2 text-sm text-gray-400 text-center"
              >
                No options
              </div>
            </div>
          </div>
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
        <span class="h-7 flex items-center text-sm text-gray-400 cursor-pointer hover:text-gray-600">
          {{ items.length > maxVisible ? `${items.length - maxVisible} more...` : items.length ? 'Edit...' : 'Empty' }}
        </span>
        <template #popper>
          <div class="rp-dropdown">
            <input
              ref="searchInput"
              v-model="search"
              class="px-2 py-1.5 border-none border-b border-gray-200 text-sm outline-none"
              placeholder="Search..."
              @vue:mounted="focusSearch"
            >
            <div class="overflow-y-auto max-h-56">
              <button
                v-for="opt in filtered"
                :key="opt.value"
                class="flex items-center justify-between w-full px-2 py-1.5 text-sm text-left border-none bg-transparent cursor-pointer hover:bg-gray-100"
                :class="{ 'text-blue-500': items.includes(opt.value) }"
                @click="toggle(opt.value)"
              >
                <span class="truncate">{{ opt.label }}</span>
                <span
                  v-if="items.includes(opt.value)"
                  class="text-blue-500 text-xs shrink-0"
                >✓</span>
              </button>
              <button
                v-if="search.trim() && !exactMatch"
                class="flex items-center w-full px-2 py-1.5 text-sm text-blue-500 font-medium border-none bg-transparent cursor-pointer hover:bg-gray-100"
                @click="add(search.trim())"
              >
                Add "{{ search.trim() }}"
              </button>
              <div
                v-if="!filtered.length && !search.trim()"
                class="p-2 text-sm text-gray-400 text-center"
              >
                No options
              </div>
            </div>
          </div>
        </template>
      </VDropdown>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { Dropdown as VDropdown } from 'floating-vue';
import { PhFileText } from '@phosphor-icons/vue';
import { httpClient } from '../services/http.client';

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
  setTimeout(() => searchInput.value?.focus(), 50);
}

onMounted(async () => {
  if (props.enumOptions) {
    options.value = props.enumOptions.map((v) => ({ value: v, label: v }));
  } else if (props.contentType) {
    try {
      const { data } = await httpClient.get('/list', { params: { type: props.contentType } });
      options.value = data.map((d: { slug: string; title: string }) => ({ value: d.slug, label: d.title }));
    } catch { /* fallback to empty */ }
  }
});
</script>

<style scoped>
.rp-dropdown {
  width: 15rem;
  max-height: 17.5rem;
  display: flex;
  flex-direction: column;
}
</style>
