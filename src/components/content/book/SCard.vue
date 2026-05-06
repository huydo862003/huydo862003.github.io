<template>
  <div class="border border-border rounded-sm px-4 py-3">
    <router-link
      :to="to"
      class="flex items-center gap-2 text-sm font-semibold text-fg no-underline hover:text-accent-blue transition-colors"
    >
      <GIcon
        v-if="icon"
        :name="icon"
      />
      {{ data[titleKey] }}
    </router-link>
    <p
      v-if="showMeta && hasMeta"
      class="text-xs text-fg-faint mt-0.5 ml-5 mb-2"
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
  GIconName,
} from '@hdnax/genuix';
import {
  GIcon,
} from '@hdnax/genuix';
import HierarchicalList from '@/components/content/book/HierarchicalList.vue';

export interface SCardConfig<T> {
  titleKey: keyof T | string;
  icon?: GIconName;
  routeTemplate: string;
  routeParams?: Record<string, string>;
  metaKeys?: (keyof T | string)[];
  childrenResolver?: (item: T) => T[];
  currentSlug?: string;
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
  renderChildren: false,
}));
</script>
