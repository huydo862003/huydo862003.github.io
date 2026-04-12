<template>
  <Transition name="split">
    <div
      v-if="open"
      class="graph-pane"
      :style="{ width: paneWidth + 'px' }"
    >
      <!-- Drag-to-resize handle on the left edge -->
      <div
        class="resize-handle"
        @mousedown.prevent="startResize"
      />

      <div class="pane-header">
        <span class="pane-title">Knowledge Graph</span>
        <div class="header-controls">
          <button
            class="ctrl-btn"
            title="Zoom in"
            @click="graphRef?.zoomIn()"
          >
            <PhPlus :size="13" />
          </button>
          <button
            class="ctrl-btn"
            title="Zoom out"
            @click="graphRef?.zoomOut()"
          >
            <PhMinus :size="13" />
          </button>
          <button
            class="ctrl-btn"
            title="Fit to view"
            @click="graphRef?.zoomFit()"
          >
            <PhArrowsOut :size="13" />
          </button>
          <button
            class="ctrl-btn"
            title="Recenter"
            @click="graphRef?.recenter()"
          >
            <PhCrosshair :size="13" />
          </button>
          <router-link
            to="/graph"
            class="ctrl-btn"
            title="Fullscreen"
            @click="open = false"
          >
            <PhFrameCorners :size="13" />
          </router-link>
          <button
            class="ctrl-btn close-btn"
            title="Close graph"
            @click="open = false"
          >
            <PhX
              :size="14"
              weight="bold"
            />
          </button>
        </div>
      </div>

      <div class="pane-body">
        <KnowledgeGraph
          ref="graphRef"
          :in-panel="true"
        />
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import {
  ref, defineAsyncComponent, onUnmounted,
} from 'vue';
import {
  PhX, PhPlus, PhMinus, PhArrowsOut, PhCrosshair, PhFrameCorners,
} from '@phosphor-icons/vue';

const KnowledgeGraph = defineAsyncComponent(() => import('@/components/KnowledgeGraph.vue'));

const open = ref(false);
const graphRef = ref<InstanceType<typeof KnowledgeGraph>>();

// ── Drag-to-resize ──────────────────────────────────────────────────────────
const MIN_WIDTH = 280;
const MAX_WIDTH = 900;
const paneWidth = ref(
  typeof window !== 'undefined'
    ? Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, Math.round(window.innerWidth * 0.5)))
    : 480,
);

let dragging = false;

function startResize (_e: MouseEvent) {
  dragging = true;
  document.body.style.cursor = 'ew-resize';
  document.body.style.userSelect = 'none';
  window.addEventListener('mousemove', onMouseMove);
  window.addEventListener('mouseup', stopResize);
}

function onMouseMove (e: MouseEvent) {
  if (!dragging) return;
  paneWidth.value = Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, window.innerWidth - e.clientX));
  window.dispatchEvent(new Event('resize'));
}

function stopResize () {
  if (!dragging) return;
  dragging = false;
  document.body.style.cursor = '';
  document.body.style.userSelect = '';
  window.removeEventListener('mousemove', onMouseMove);
  window.removeEventListener('mouseup', stopResize);
}

onUnmounted(stopResize);

// ── Public API ──────────────────────────────────────────────────────────────
function show () {
  open.value = true;
}
function close () {
  open.value = false;
}
function toggle () {
  open.value = !open.value;
}

defineExpose({
  show,
  close,
  toggle,
  open,
});
</script>

<style scoped>
@reference "../style.css";
.graph-pane {
  /* Stays in the viewport while left content scrolls */
  position: sticky;
  top: 0;
  height: 100svh;
  align-self: flex-start;

  display: flex;
  flex-direction: column;
  border-left: 1px solid var(--color-border);
  background: var(--color-bg);
  min-width: 280px;
  max-width: 900px;
  flex-shrink: 0;
}
.resize-handle {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 5px;
  z-index: 10;
  cursor: ew-resize;
}
.resize-handle:hover {
  background: oklch(0.6 0.15 250 / 0.25);
}
.pane-header {
  @apply flex items-center justify-between px-3 py-2 border-b border-border shrink-0;
}
.pane-title {
  @apply text-xs font-semibold text-fg-muted;
}
.header-controls {
  @apply flex items-center gap-0.5;
}
.ctrl-btn {
  @apply p-1.5 rounded-sm cursor-pointer transition-colors text-fg-faint hover:text-fg no-underline;
}
.close-btn {
  @apply ml-1;
}
.pane-body {
  flex: 1;
  min-height: 0;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}
.split-enter-active,
.split-leave-active {
  transition: width 0.2s ease, opacity 0.15s ease;
  overflow: hidden;
}
.split-enter-from,
.split-leave-to {
  width: 0 !important;
  opacity: 0;
}
</style>
