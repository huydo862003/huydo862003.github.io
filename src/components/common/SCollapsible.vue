<template>
  <div class="section">
    <div class="header">
      <span class="label">{{ label }}</span>
      <input
        v-if="items.length > 10"
        v-model="search"
        type="text"
        placeholder="Filter..."
        class="filter"
      >
    </div>
    <ul :class="['list', columns === 1 ? 'cols-1' : 'cols-2']">
      <li
        v-for="item in filtered"
        :key="item.value"
      >
        <router-link
          v-if="item.to"
          :to="item.to"
          class="item-link"
        >
          {{ item.label }}
        </router-link>
        <span
          v-else
          class="item-text"
        >{{ item.label }}</span>
      </li>
    </ul>
    <p
      v-if="!filtered.length"
      class="no-match"
    >
      No match.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed,
} from 'vue';

const {
  label, items, columns = 2,
} = defineProps<{
  label: string;
  items: {value: string;
    label: string;
    to?: string;}[];
  columns?: 1 | 2;
}>();

const search = ref('');

const filtered = computed(() => {
  if (!search.value) return items;
  const q = search.value.toLowerCase();
  return items.filter((i) => i.label.toLowerCase().includes(q));
});
</script>

<style scoped>
@reference "../../style.css";
@reference "../../style.css";
.section {
  @apply mb-5;
}
.header {
  @apply flex items-center gap-2 mb-2;
}
.label {
  @apply text-xs font-semibold uppercase tracking-wider text-fg-faint;
}
.filter {
  @apply text-xs px-1.5 py-0.5 bg-transparent text-fg border border-border
         rounded-sm outline-none w-24 placeholder:text-fg-faint/40
         focus:border-fg-faint transition-colors;
}
.list {
  @apply list-none p-0 m-0 pr-3 max-h-48 overflow-y-auto;
}
.cols-2 {
  @apply columns-2 gap-x-6;
}
.cols-1 {
  @apply columns-1;
}
.item-link {
  @apply block text-xs text-fg-muted no-underline hover:text-accent-blue
         truncate py-0.5 transition-colors;
}
.item-text {
  @apply block text-xs text-fg-faint truncate py-0.5;
}
.no-match {
  @apply text-xs text-fg-faint;
}
</style>
