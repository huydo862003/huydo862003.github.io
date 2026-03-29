<template>
  <div class="graph-page">
    <div class="toolbar">
      <button
        class="ctrl-btn"
        title="Back"
        @click="$router.back()"
      >
        <PhArrowLeft :size="14" />
      </button>
      <span class="info">{{ nodes.length }} nodes, {{ edges.length }} edges</span>
      <div class="controls">
        <button
          class="ctrl-btn"
          title="Zoom in"
          @click="zoomIn"
        >
          <PhPlus :size="14" />
        </button>
        <button
          class="ctrl-btn"
          title="Zoom out"
          @click="zoomOut"
        >
          <PhMinus :size="14" />
        </button>
        <button
          class="ctrl-btn"
          title="Fit to view"
          @click="zoomFit"
        >
          <PhArrowsOut :size="14" />
        </button>
        <button
          class="ctrl-btn"
          title="Recenter"
          @click="recenter"
        >
          <PhCrosshair :size="14" />
        </button>
      </div>
    </div>
    <div
      ref="container"
      class="canvas"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed,
} from 'vue';
import {
  PhArrowLeft, PhPlus, PhMinus, PhArrowsOut, PhCrosshair,
} from '@phosphor-icons/vue';
import { useGraph } from '@/composables/useGraph';
import {
  nodes, edges,
} from '@/utils/graph';

const container = ref<HTMLElement>();
const h = computed(() => window.innerHeight - 40);

const {
  zoomIn, zoomOut, zoomFit, recenter,
} = useGraph(container, h);
</script>

<style scoped>
@reference "../../style.css";
.graph-page {
  @apply flex flex-col h-screen;
  background: #141414;
  color: #d4d4d4;
}
.toolbar {
  @apply flex items-center gap-4 px-4 h-10 shrink-0;
  border-bottom: 1px solid #2a2a2a;
}
.info {
  @apply text-xs;
  color: #666;
}
.controls {
  @apply flex items-center gap-1 ml-auto;
}
.ctrl-btn {
  @apply p-1.5 rounded-sm cursor-pointer transition-colors;
  color: #666;
}
.ctrl-btn:hover {
  color: #d4d4d4;
  background: #1c1c1c;
}
.canvas {
  @apply flex-1;
}
</style>
