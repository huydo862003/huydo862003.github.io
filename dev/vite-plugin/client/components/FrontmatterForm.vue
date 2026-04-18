<template>
  <div class="border-b border-gray-200 mb-1 overflow-visible">
    <!-- editable title -->
    <div class="px-3 pt-3 pb-1">
      <input
        v-if="editingTitle"
        ref="titleInput"
        :value="displayTitle ?? ''"
        class="text-lg font-semibold w-full border-none outline-none bg-transparent"
        @blur="finishTitleEdit"
        @keydown.enter="finishTitleEdit"
        @vue:mounted="($el: HTMLInputElement) => $el.focus()"
      >
      <span
        v-else
        class="text-lg font-semibold cursor-text"
        @dblclick="editingTitle = true"
      >{{ displayTitle || 'Untitled' }}</span>
    </div>

    <!-- properties -->
    <div class="px-3 pb-2 overflow-visible">
      <!-- common: published -->
      <div class="fm-row">
        <div class="fm-label">
          <PhCheckSquare :size="14" />
          <span class="truncate">Published</span>
        </div>
        <div class="fm-value">
          <input
            type="checkbox"
            :checked="!!frontmatter.published"
            @change="update('published', ($event.target as HTMLInputElement).checked)"
          >
        </div>
      </div>

      <!-- common: author -->
      <div class="fm-row">
        <div class="fm-label">
          <PhUser :size="14" />
          <span class="truncate">Author</span>
        </div>
        <div class="fm-value">
          <input
            :value="frontmatter.author ?? ''"
            class="fm-input"
            placeholder="Empty"
            @input="update('author', ($event.target as HTMLInputElement).value)"
          >
        </div>
      </div>

      <!-- common: dates -->
      <div class="fm-row">
        <div class="fm-label">
          <PhCalendar :size="14" />
          <span class="truncate">Updated</span>
        </div>
        <div class="fm-value">
          <input
            type="date"
            :value="frontmatter.updatedAt ?? ''"
            class="fm-input"
            @input="update('updatedAt', ($event.target as HTMLInputElement).value)"
          >
        </div>
      </div>

      <!-- schema-driven fields -->
      <div
        v-for="(fieldSchema, fieldName) in visibleFields"
        :key="fieldName"
        class="fm-row"
      >
        <div class="fm-label">
          <component
            :is="fieldSchema.ref ? PhArrowSquareOut : fieldIcon(fieldSchema.type)"
            :size="14"
          />
          <span class="truncate">{{ fieldSchema.label ?? fieldName }}</span>
        </div>
        <div class="fm-value">
          <!-- boolean -->
          <input
            v-if="fieldSchema.type === 'boolean'"
            type="checkbox"
            :checked="!!fieldValue(fieldName, fieldSchema)"
            @change="update(String(fieldName), ($event.target as HTMLInputElement).checked)"
          >

          <!-- enum: pill badge with dropdown -->
          <VDropdown
            v-else-if="fieldSchema.type === 'enum'"
            :distance="6"
            :arrow-overflow="false"
            placement="bottom-start"
          >
            <span
              class="inline-flex items-center gap-1 h-7 px-2.5 rounded-full text-sm cursor-pointer"
              :style="enumPillColor(String(fieldValue(fieldName, fieldSchema)))"
            >
              <span class="w-1.5 h-1.5 rounded-full bg-current opacity-60" />
              {{ fieldValue(fieldName, fieldSchema) || 'Select...' }}
            </span>
            <template #popper>
              <div class="flex flex-col py-1 min-w-32">
                <button
                  v-for="opt in resolveEnum(fieldSchema)"
                  :key="opt"
                  class="flex items-center gap-2 px-3 py-1.5 text-sm text-left border-none bg-transparent cursor-pointer hover:bg-gray-100"
                  @click="update(String(fieldName), opt)"
                >
                  <span
                    class="w-1.5 h-1.5 rounded-full"
                    :style="{ background: enumDotColor(opt) }"
                  />
                  {{ opt }}
                </button>
              </div>
            </template>
          </VDropdown>

          <!-- date -->
          <input
            v-else-if="fieldSchema.type === 'date'"
            type="date"
            :value="fieldValue(fieldName, fieldSchema)"
            class="fm-input"
            placeholder="Empty"
            @input="update(String(fieldName), ($event.target as HTMLInputElement).value)"
          >

          <!-- number -->
          <input
            v-else-if="fieldSchema.type === 'number'"
            type="number"
            :value="fieldValue(fieldName, fieldSchema)"
            class="fm-input"
            placeholder="Empty"
            @input="update(String(fieldName), Number(($event.target as HTMLInputElement).value))"
          >

          <!-- multi ref or array (tags/relations) -->
          <RelationPicker
            v-else-if="fieldSchema.type === 'array' || (fieldSchema.ref && fieldSchema.multi)"
            :model-value="toArray(fieldValue(fieldName, fieldSchema))"
            :content-type="fieldSchema.ref"
            :enum-options="resolveEnum(fieldSchema)"
            @update:model-value="update(String(fieldName), $event as unknown)"
            @navigate="$emit('navigate', $event)"
          />

          <!-- single ref -->
          <RelationPicker
            v-else-if="fieldSchema.ref && !fieldSchema.multi"
            :model-value="fieldValue(fieldName, fieldSchema) ? [String(fieldValue(fieldName, fieldSchema))] : []"
            :content-type="fieldSchema.ref"
            :single="true"
            @update:model-value="update(String(fieldName), ($event as string[])[0] ?? '')"
            @navigate="$emit('navigate', $event)"
          />

          <!-- plain string -->
          <input
            v-else
            :value="fieldValue(fieldName, fieldSchema)"
            class="fm-input"
            placeholder="Empty"
            @input="update(String(fieldName), ($event.target as HTMLInputElement).value)"
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import {
  PhCheckSquare, PhUser, PhCalendar,
  PhTextAa, PhHash, PhToggleLeft, PhListBullets, PhTag, PhArrowSquareOut,
} from '@phosphor-icons/vue';
import { Dropdown as VDropdown } from 'floating-vue';
import type { ContentSchema, FieldSchema } from '../services/schema.service';
import RelationPicker from './RelationPicker.vue';

const props = defineProps<{
  frontmatter: Record<string, unknown>;
  schema?: ContentSchema;
}>();
const emit = defineEmits<{ update: [key: string, value: unknown] }>();

const editingTitle = ref(false);
const titleInput = ref<HTMLInputElement>();

const displayNameField = computed(() => props.schema?.displayName ?? 'title');

const displayTitle = computed(() => {
  const field = props.schema?.displayName ?? 'title';
  return props.frontmatter[field] as string | undefined;
});

const COMMON_FIELDS = new Set(['published', 'author', 'createdAt', 'updatedAt']);

const visibleFields = computed(() => {
  if (!props.schema?.fields) return {};
  return Object.fromEntries(
    Object.entries(props.schema.fields).filter(([k, f]) => !f.hidden && !COMMON_FIELDS.has(k)),
  );
});

const FIELD_ICONS: Record<string, unknown> = {
  string: PhTextAa,
  number: PhHash,
  boolean: PhToggleLeft,
  enum: PhTag,
  array: PhListBullets,
  date: PhCalendar,
};

function fieldIcon (type: string) {
  return FIELD_ICONS[type] ?? PhTextAa;
}

function fieldValue (name: string | number, schema: FieldSchema) {
  return props.frontmatter[name] ?? schema.default ?? (schema.type === 'array' ? [] : schema.type === 'boolean' ? false : '');
}

function resolveEnum (field: FieldSchema): string[] {
  if (!field.enum || !props.schema) return [];
  const enumDef = props.schema.enums?.[field.enum];
  if (!enumDef) return [];
  if (Array.isArray(enumDef)) return enumDef;
  if (field.conditionOn) {
    const key = String(props.frontmatter[field.conditionOn] ?? '');
    return enumDef[key] ?? [];
  }
  return [];
}

function toArray (val: unknown): string[] {
  if (Array.isArray(val)) return val as string[];
  if (val && typeof val === 'string') return [val];
  return [];
}

const ENUM_COLORS: Record<string, { bg: string; fg: string; dot: string }> = {
  active: { bg: '#dbeafe', fg: '#1e40af', dot: '#3b82f6' },
  learning: { bg: '#dbeafe', fg: '#1e40af', dot: '#3b82f6' },
  reading: { bg: '#fef3c7', fg: '#92400e', dot: '#f59e0b' },
  reviewing: { bg: '#ede9fe', fg: '#5b21b6', dot: '#8b5cf6' },
  mastered: { bg: '#d1fae5', fg: '#065f46', dot: '#10b981' },
  completed: { bg: '#d1fae5', fg: '#065f46', dot: '#10b981' },
  paused: { bg: '#f3f4f6', fg: '#6b7280', dot: '#9ca3af' },
  'on-hold': { bg: '#f3f4f6', fg: '#6b7280', dot: '#9ca3af' },
  'to-read': { bg: '#fce7f3', fg: '#9d174d', dot: '#ec4899' },
  read: { bg: '#d1fae5', fg: '#065f46', dot: '#10b981' },
};
const DEFAULT_PILL = { bg: '#f3f4f6', fg: '#374151', dot: '#9ca3af' };

function enumPillColor (value: string): Record<string, string> {
  const c = ENUM_COLORS[value] ?? DEFAULT_PILL;
  return { background: c.bg, color: c.fg };
}

function enumDotColor (value: string): string {
  return (ENUM_COLORS[value] ?? DEFAULT_PILL).dot;
}

function finishTitleEdit () {
  if (titleInput.value) {
    update(displayNameField.value, titleInput.value.value);
  }
  editingTitle.value = false;
}

function update (key: string, value: unknown) {
  emit('update', key, value);
}
</script>

<style scoped>
@reference "tailwindcss";

.fm-row {
  @apply flex items-start gap-3 text-sm;
  min-height: 1.75rem;
  padding: 0.15rem 0;
  line-height: 1.75rem;
}
.fm-label {
  @apply flex items-center gap-1.5 shrink-0 text-gray-400 text-sm overflow-hidden;
  width: 7.5rem;
  height: 1.75rem;
}
.fm-value {
  @apply flex-1 min-w-0 flex items-center;
  min-height: 1.75rem;
}
.fm-input {
  @apply w-full h-7 px-1.5 border-none rounded text-sm bg-transparent truncate;
  box-sizing: border-box;
}
.fm-input::placeholder { @apply text-gray-300; }
.fm-input:hover { @apply bg-gray-50; }
.fm-input:focus { @apply bg-gray-100 outline-none; white-space: normal; overflow: visible; }
</style>
