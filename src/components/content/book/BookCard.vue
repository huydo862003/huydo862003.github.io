<template>
  <GToc>
    <GTocItem>
      <template #leading>
        <GIcon
          v-if="icon"
          :name="icon"
          :size="12"
        />
      </template>
      <template #default>
        <RouterLink
          :to="to"
          class="book-link"
          :class="{
            active: isActive,
          }"
        >
          {{ data[titleKey] }}
        </RouterLink>
      </template>
      <template
        v-if="showMeta && hasMeta"
        #meta
      >
        <span
          v-for="(value, key, idx) in metaDisplay"
          :key="String(key)"
        >
          <span v-if="idx > 0"> · </span>{{ value }}
        </span>
      </template>
      <template
        v-if="children.length && renderChildren"
        #children
      >
        <GTocItem
          v-for="child in children"
          :key="childKey(child)"
        >
          <template #default>
            <RouterLink
              :to="childRoute(child)"
              class="book-link"
              :class="{
                active: isChildActive(child),
              }"
            >
              {{ child[titleKey] }}
            </RouterLink>
          </template>
          <template
            v-if="grandchildren(child).length"
            #children
          >
            <GTocItem
              v-for="grandchild in grandchildren(child)"
              :key="childKey(grandchild)"
            >
              <template #default>
                <RouterLink
                  :to="childRoute(grandchild)"
                  class="book-link"
                  :class="{
                    active: isChildActive(grandchild),
                  }"
                >
                  {{ grandchild[titleKey] }}
                </RouterLink>
              </template>
            </GTocItem>
          </template>
        </GTocItem>
      </template>
    </GTocItem>
  </GToc>
</template>

<script setup lang="ts" generic="T extends Record<string, any>">
import {
  computed,
} from 'vue';
import type {
  GIconName,
} from '@hdnax/genuix';
import {
  GIcon, GToc, GTocItem,
} from '@hdnax/genuix';

export interface BookCardConfig<T> {
  titleKey: keyof T | string;
  icon?: GIconName;
  routeTemplate: string;
  routeParams?: Record<string, string>;
  metaKeys?: (keyof T | string)[];
  childrenResolver?: (item: T) => T[];
  currentSlug?: string;
  renderChildren?: boolean;
}

const {
  data, config,
} = defineProps<{
  /** The data object to display */
  data: T;
  /** Configuration for how to display the card */
  config: BookCardConfig<T>;
}>();

const titleKey = computed(() => config.titleKey as string);
const icon = config.icon;
const currentSlug = computed(() => config.currentSlug ?? '');
const context = computed(() => config.routeParams ?? {});
const renderChildren = computed(() => config.renderChildren !== false);

function buildRoute (item: T): string {
  const template = config.routeTemplate;
  const itemData = item as Record<string, unknown>;
  const parameters = {
    ...context.value,
    ...itemData,
  };

  return template.replace(/{(\w+)}/g, (_, key) => String(parameters[key] ?? ''));
}

const to = computed(() => buildRoute(data));

const isActive = computed(() => {
  const itemData = data as Record<string, unknown>;
  const slug = itemData.slug ?? itemData.id ?? itemData[titleKey.value];

  return String(slug) === currentSlug.value;
});

const showMeta = computed(() => 0 < (config.metaKeys?.length ?? 0));
const hasMeta = computed(() => {
  const metaKeys = config.metaKeys ?? [];
  const itemData = data as Record<string, unknown>;

  return metaKeys.some((key) => itemData[key as string]);
});

const metaDisplay = computed(() => {
  const metaKeys = config.metaKeys ?? [];
  const itemData = data as Record<string, unknown>;
  const result: Record<string, unknown> = {};

  for (const key of metaKeys) {
    const value = itemData[key as string];

    if (value) result[key as string] = value;
  }

  return result;
});

const children = computed(() => {
  const resolver = config.childrenResolver;

  if (!resolver) return [];

  return resolver(data);
});

function childKey (child: T): string {
  const childData = child as Record<string, unknown>;

  return String(childData.slug ?? childData.id ?? childData[titleKey.value]);
}

function childRoute (child: T): string {
  return buildRoute(child);
}

function grandchildren (child: T): T[] {
  const resolver = config.childrenResolver;

  if (!resolver) return [];

  return resolver(child);
}

function isChildActive (child: T): boolean {
  return childKey(child) === currentSlug.value;
}
</script>

<style scoped>
.book-link {
  font-size: 0.75rem;
  text-decoration: none;
  transition: color 0.15s;
  color: var(--gui-neutral-fg-muted);
}
.book-link:hover {
  color: var(--gui-info-solid);
}
.book-link.active {
  font-weight: 600;
  color: var(--gui-neutral-fg);
}
</style>
