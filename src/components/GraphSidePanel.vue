<template>
  <Transition name="side-panel">
    <div
      v-if="open"
      class="side-panel"
    >
      <div class="side-panel-header">
        <span class="side-panel-title">Knowledge Graph</span>
        <button
          class="close-btn"
          title="Close graph"
          @click="open = false"
        >
          <PhX :size="16" weight="bold" />
        </button>
      </div>
      <div class="side-panel-body">
        <KnowledgeGraph v-if="open" />
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import { ref, defineAsyncComponent } from 'vue';
import { PhX } from '@phosphor-icons/vue';

const KnowledgeGraph = defineAsyncComponent(() => import('@/components/KnowledgeGraph.vue'));

const open = ref(false);

function show () {
  open.value = true;
}

function close () {
  open.value = false;
}

function toggle () {
  open.value = !open.value;
}

defineExpose({ show, close, toggle, open });
</script>

<style scoped>
@reference "../style.css";
.side-panel {
  @apply fixed top-0 right-0 h-full z-40 flex flex-col border-l border-border bg-bg shadow-2xl;
  width: clamp(320px, 35vw, 560px);
}
.side-panel-header {
  @apply flex items-center justify-between px-4 py-3 border-b border-border shrink-0;
}
.side-panel-title {
  @apply text-xs font-semibold text-fg-muted;
}
.close-btn {
  @apply text-fg-faint hover:text-fg p-1 cursor-pointer;
}
.side-panel-body {
  @apply flex-1 overflow-hidden;
}
.side-panel-enter-active,
.side-panel-leave-active {
  transition: transform 0.2s ease, opacity 0.2s ease;
}
.side-panel-enter-from,
.side-panel-leave-to {
  transform: translateX(100%);
  opacity: 0;
}
</style>
