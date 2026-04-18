<template>
  <li class="tree-item">
    <div
      class="tree-label"
      :class="{ active: store.currentPath === node.path, dir: node.type === 'dir' }"
      :style="{ paddingLeft: `${depth * 1}rem` }"
      @click="toggle"
    >
      <PhCaretRight
        v-if="node.type === 'dir'"
        class="tree-chevron"
        :class="{ 'tree-chevron-open': open }"
        :size="10"
      />
      <PhFolderOpen
        v-if="node.type === 'dir' && open"
        class="tree-icon"
        :size="14"
      />
      <PhFolder
        v-else-if="node.type === 'dir'"
        class="tree-icon"
        :size="14"
      />
      <component
        :is="fileIcon"
        v-else
        class="tree-icon"
        :size="14"
      />
      <span class="tree-name">{{ displayName }}</span>
    </div>
    <ul
      v-if="node.type === 'dir' && open && node.children"
      class="tree-children"
    >
      <TreeItem
        v-for="child in node.children"
        :key="child.path"
        :node="child"
        :depth="depth + 1"
        @select="(p: string) => emit('select', p)"
      />
    </ul>
  </li>
</template>

<script setup lang="ts">
import {
  ref, computed, inject, watch,
} from 'vue';
import type { Ref } from 'vue';
import {
  PhFolder, PhFolderOpen, PhFileText, PhCaretRight,
  PhLightbulb, PhFlashlight, PhBooks, PhNewspaper, PhArticle, PhNotebook, PhUser, PhMapTrifold,
} from '@phosphor-icons/vue';
import {
  useFileStore,
} from '../stores/file.store';
import type {
  TreeNode,
} from '../services/tree.service';

const props = defineProps<{ node: TreeNode; depth: number }>();
const emit = defineEmits<{ select: [path: string] }>();
const store = useFileStore();
const open = ref(props.depth < 1);
const collapseSignal = inject<Ref<number>>('collapseSignal');
if (collapseSignal) watch(collapseSignal, () => { open.value = false; });

// derive content type from top-level segment of path
const contentType = computed(() => props.node.path.split('/')[0]);

const FILE_ICONS: Record<string, unknown> = {
  concepts: PhLightbulb,
  flashcards: PhFlashlight,
  books: PhBooks,
  papers: PhNewspaper,
  blogs: PhArticle,
  thoughts: PhNotebook,
  authors: PhUser,
  journeys: PhMapTrifold,
};

const fileIcon = computed(() => FILE_ICONS[contentType.value] ?? PhFileText);

// strip .md, replace hyphens with spaces
const displayName = computed(() => {
  const name = props.node.name.replace(/\.md$/, '');
  return name.replace(/-/g, ' ');
});

function toggle () {
  if (props.node.type === 'dir') {
    open.value = !open.value;
  } else {
    emit('select', props.node.path);
  }
}
</script>

<style scoped>
.tree-item { list-style: none; }
.tree-label {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.2rem 0.4rem;
  cursor: pointer;
  border-radius: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.tree-label:hover { background: var(--bg-hover, #f3f4f6); }
.tree-label.active { background: var(--bg-active, #dbeafe); font-weight: 600; }
.tree-label.dir { font-weight: 500; }
.tree-icon { font-size: 0.7rem; flex-shrink: 0; width: 1rem; text-align: center; }
.tree-chevron { flex-shrink: 0; transition: transform 0.15s ease; }
.tree-chevron-open { transform: rotate(90deg); }
.tree-name { overflow: hidden; text-overflow: ellipsis; }
.tree-children {
  list-style: none;
  padding: 0;
  margin: 0;
}
</style>
