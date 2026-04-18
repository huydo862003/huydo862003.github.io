<template>
  <div class="content-tree">
    <div class="tree-header">
      <h3>Content</h3>
      <div style="display:flex;gap:0.25rem">
        <button
          class="btn-sm"
          title="Upload asset"
          @click="fileInput?.click()"
        >
          <PhUpload :size="14" />
        </button>
        <button
          class="btn-sm"
          title="Collapse all"
          @click="collapseSignal++"
        >
          <PhArrowsIn :size="14" />
        </button>
        <button
          class="btn-sm"
          title="Refresh"
          @click="store.loadTree()"
        >
          <PhArrowClockwise :size="14" />
        </button>
      </div>
      <input
        ref="fileInput"
        type="file"
        style="display:none"
        multiple
        @change="uploadFiles"
      >
    </div>
    <div
      v-if="store.treeLoading"
      class="tree-loading"
    >
      Loading…
    </div>
    <ul
      v-else
      class="tree-root"
    >
      <TreeItem
        v-for="node in store.tree"
        :key="node.path"
        :node="node"
        :depth="0"
        @select="onSelect"
      />
    </ul>
  </div>
</template>

<script setup lang="ts">
import {
  onMounted, provide, ref,
} from 'vue';
import {
  httpClient,
} from '../services/http.client';
import {
  PhArrowClockwise, PhArrowsIn, PhUpload,
} from '@phosphor-icons/vue';
import {
  useTreeStore,
} from '../stores/tree.store';
import TreeItem from './TreeItem.vue';

const store = useTreeStore();
const emit = defineEmits<{ select: [path: string] }>();
const fileInput = ref<HTMLInputElement>();

// incremented to signal all TreeItems to collapse
const collapseSignal = ref(0);
provide('collapseSignal', collapseSignal);

function onSelect (path: string) {
  emit('select', path);
}

async function uploadFiles (e: Event) {
  const input = e.target as HTMLInputElement;
  if (!input.files) return;
  await Promise.all([...input.files].map((file) => {
    const form = new FormData();
    form.append('file', file);
    return httpClient.post('/assets/upload', form);
  }));
  input.value = '';
}

onMounted(() => {
  if (store.tree.length === 0) store.loadTree();
});
</script>

<style scoped>
.content-tree {
  height: 100%;
  overflow-y: auto;
  font-size: 0.85rem;
  padding: 0.5rem;
}
.tree-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 0.25rem 0.5rem;
  border-bottom: 1px solid var(--border, #e5e7eb);
  margin-bottom: 0.5rem;
}
.tree-header h3 {
  margin: 0;
  font-size: 0.9rem;
}
.btn-sm {
  background: none;
  border: 1px solid var(--border, #e5e7eb);
  border-radius: 4px;
  cursor: pointer;
  padding: 0.15rem 0.4rem;
  font-size: 0.85rem;
}
.btn-sm:hover { background: var(--bg-hover, #f3f4f6); }
.tree-root {
  list-style: none;
  padding: 0;
  margin: 0;
}
.tree-loading {
  padding: 1rem;
  color: var(--text-muted, #6b7280);
}
</style>
