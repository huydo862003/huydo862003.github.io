<template>
  <ul :class="isRoot ? 'items' : 'sub-items'">
    <li
      v-for="item in items"
      :key="itemKey(item)"
    >
      <div class="item-row">
        <router-link
          :to="itemRoute(item)"
          :class="['item-link', { active: isActive(item) }]"
        >
          {{ item[config.titleKey as string] }}
        </router-link>
        <span
          v-if="showMeta && metaValue(item)"
          class="item-meta"
        >{{ metaValue(item) }}</span>
      </div>
      <HierarchicalList
        v-if="hasChildren(item) && config.renderChildren !== false"
        :items="getChildren(item)"
        :config="config"
        :current-slug="currentSlug"
        :depth="depth + 1"
        :context="context"
      />
    </li>
  </ul>
</template>

<script setup lang="ts" generic="T extends Record<string, any>">
import { computed } from 'vue';
import type { SCardConfig } from './SCard.vue';

const props = defineProps<{
  items: T[];
  config: SCardConfig<T>;
  currentSlug?: string;
  depth?: number;
  context?: Record<string, string>;
}>();

const depth = computed(() => props.depth ?? 0);
const isRoot = computed(() => depth.value === 0);
const currentSlug = computed(() => props.currentSlug ?? '');
const context = computed(() => props.context ?? {});

const itemKeyField = computed(() => {
  const config = props.config;
  // Try to find a common key field (id, slug, etc)
  for (const item of props.items) {
    if ('slug' in item) return 'slug';
    if ('id' in item) return 'id';
  }
  return config.titleKey;
});

function itemKey (item: T): string {
  const key = itemKeyField.value as string;
  const value = (item as Record<string, any>)[key];
  return String(value);
}

function itemRoute (item: T): string {
  const template = props.config.routeTemplate;
  const data = item as Record<string, any>;
  const params = {
    ...context.value,
    ...data,
  };

  return template.replace(/{(\w+)}/g, (_, key) => params[key] ?? '');
}

function isActive (item: T): boolean {
  const key = itemKeyField.value as string;
  const itemId = (item as Record<string, any>)[key];
  return String(itemId) === currentSlug.value;
}

function hasChildren (item: T): boolean {
  const resolver = props.config.childrenResolver;
  if (!resolver) return false;
  const children = resolver(item);
  return Array.isArray(children) && 0 < children.length;
}

function getChildren (item: T): T[] {
  const resolver = props.config.childrenResolver;
  if (!resolver) return [];
  const children = resolver(item);
  return Array.isArray(children) ? children : [];
}

const showMeta = computed(() => {
  const config = props.config;
  // Check if first item has a metadata field we can display
  if (!props.items.length || !config.metaKeys?.length) return false;

  const first = props.items[0] as Record<string, any>;
  for (const key of config.metaKeys) {
    if ((key as string) in first) return true;
  }
  return false;
});

function metaValue (item: T): string {
  const config = props.config;
  const metaKeys = config.metaKeys ?? [];
  const data = item as Record<string, any>;

  for (const key of metaKeys) {
    const value = data[key as string];
    if (value) {
      // Handle arrays like concepts
      if (Array.isArray(value)) {
        return `${value.length} ${String(key).toLowerCase()}`;
      }
      return String(value);
    }
  }
  return '';
}
</script>

<style scoped>
@reference "../../../style.css";
.items {
  @apply list-none p-0 m-0 flex flex-col gap-0.5;
}
.items > li {
  @apply border-l-2 border-border pl-3 py-1.5;
}
.sub-items {
  @apply list-none p-0 m-0 ml-2 mt-1 flex flex-col gap-0.5;
}
.sub-items > li {
  @apply border-l border-border/50 pl-3 py-1;
}
.item-row {
  @apply flex items-center justify-between gap-2;
}
.item-link {
  @apply text-xs text-fg-muted no-underline hover:text-accent-blue transition-colors;
}
.item-link.active {
  @apply text-fg font-semibold;
}
.item-meta {
  @apply text-xs text-fg-faint shrink-0 hidden sm:inline;
}
</style>
