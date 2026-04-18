<template>
  <div class="card">
    <router-link
      :to="to"
      class="card-title"
    >
      <component
        :is="icon"
        :size="14"
      />
      {{ data[titleKey] }}
    </router-link>
    <p
      v-if="showMeta && hasMeta"
      class="card-meta"
    >
      <span
        v-for="(value, key, idx) in metaDisplay"
        :key="key"
      >
        <span v-if="idx > 0"> · </span>
        {{ value }}
      </span>
    </p>
    <HierarchicalList
      v-if="children.length && renderChildren"
      :items="children"
      :config="listConfig"
      :current-slug="currentSlug"
      :context="context"
    />
  </div>
</template>

<script setup lang="ts" generic="T extends Record<string, any>">
import {
  computed,
} from 'vue';
import type {
  Component,
} from 'vue';
import HierarchicalList from '@/components/content/book/HierarchicalList.vue';

export interface SCardConfig<T> {
  /** Key in data object for item title */
  titleKey: keyof T | string;
  /** Icon component to display */
  icon?: Component;
  /** Route template with {key} placeholders. e.g. "/journeys/{journeySlug}/books/{slug}" */
  routeTemplate: string;
  /** Route parameters context. Keys must match those in routeTemplate */
  routeParams?: Record<string, string>;
  /** Metadata keys to display from data. e.g. ["author", "date"] */
  metaKeys?: (keyof T | string)[];
  /** Function to resolve children from an item */
  childrenResolver?: (item: T) => T[];
  /** Current active item slug for highlighting */
  currentSlug?: string;
  /** Whether to render children list */
  renderChildren?: boolean;
}

const props = defineProps<{
  data: T;
  config: SCardConfig<T>;
}>();

const titleKey = computed(() => props.config.titleKey as string);
const icon = props.config.icon;
const currentSlug = computed(() => props.config.currentSlug ?? '');
const context = computed(() => props.config.routeParams ?? {});
const renderChildren = computed(() => props.config.renderChildren !== false);

const to = computed(() => {
  const template = props.config.routeTemplate;
  const data = props.data as Record<string, any>;
  const params = {
    ...context.value,
    ...data,
  };

  return template.replace(/{(\w+)}/g, (_, key) => params[key] ?? '');
});

const showMeta = computed(() => 0 < props.config.metaKeys?.length ?? 0);
const hasMeta = computed(() => {
  const metaKeys = props.config.metaKeys ?? [];
  const data = props.data as Record<string, any>;
  return metaKeys.some((key) => data[key as string]);
});

const metaDisplay = computed(() => {
  const metaKeys = props.config.metaKeys ?? [];
  const data = props.data as Record<string, any>;
  const result: Record<string, any> = {};

  for (const key of metaKeys) {
    const value = data[key as string];
    if (value) result[key as string] = value;
  }
  return result;
});

const children = computed(() => {
  const resolver = props.config.childrenResolver;
  if (!resolver) return [];
  return resolver(props.data);
});

const listConfig = computed((): SCardConfig<T> => ({
  ...props.config,
  renderChildren: false, // Prevent infinite nesting of child lists
}));
</script>

<style scoped>
@reference "../../../style.css";
.card {
  @apply border border-border rounded-sm px-4 py-3;
}
.card-title {
  @apply flex items-center gap-2 text-sm font-semibold text-fg no-underline
         hover:text-accent-blue transition-colors;
}
.card-meta {
  @apply text-xs text-fg-faint mt-0.5 ml-5 mb-2;
}
</style>
