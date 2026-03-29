<template>
  <div>
    <div class="table-scroll">
      <table class="stable">
        <thead>
          <tr>
            <th
              v-for="col in columns"
              :key="col.key"
              :class="[col.class, { sortable: col.sortable }]"
              @click="col.sortable && handleSort(col.key)"
            >
              {{ col.label }}<span
                v-if="col.sortable && sortKey === col.key"
                class="sort-icon"
              >{{ sortAsc ? ' ↑' : ' ↓' }}</span>
            </th>
          </tr>
        </thead>
        <tbody>
          <slot />
        </tbody>
      </table>
    </div>
    <SPager
      :model-value="page"
      :total="pages"
      class="mt-6"
      @update:model-value="$emit('update:page', $event)"
    />
  </div>
</template>

<script setup lang="ts">
import SPager from './SPager.vue';

export interface TableColumn {
  key: string;
  label: string;
  sortable?: boolean;
  class?: string;
}

const props = defineProps<{
  columns: TableColumn[];
  sortKey?: string;
  sortAsc?: boolean;
  page: number;
  pages: number;
}>();

const emit = defineEmits<{
  'update:sortKey': [key: string];
  'update:sortAsc': [asc: boolean];
  'update:page': [page: number];
}>();

function handleSort (key: string) {
  if (props.sortKey !== key) {
    emit('update:sortKey', key);
    emit('update:sortAsc', true);
  } else if (props.sortAsc) {
    emit('update:sortAsc', false);
  } else {
    emit('update:sortKey', '');
  }
}
</script>

<style scoped>
@reference "../../style.css";
.table-scroll {
  @apply overflow-x-auto -mx-1 px-1;
}
.stable {
  @apply w-full text-xs border-collapse;
}
.stable th {
  @apply text-left text-xs text-fg-faint font-medium pb-2 pr-4;
}
.stable th.sortable {
  @apply cursor-pointer hover:text-fg transition-colors select-none;
}
.stable td {
  @apply py-2 pr-4 border-t border-border;
}
.sort-icon {
  @apply text-fg-faint;
}
</style>
