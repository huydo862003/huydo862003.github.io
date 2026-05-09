<template>
  <Transition name="split">
    <div
      v-if="open"
      class="graph-pane sticky top-0 h-dvh self-start flex flex-col shrink-0"
      :style="{
        width: `${paneWidth}px`,
      }"
    >
      <!-- Drag-to-resize handle on the left edge -->
      <div
        class="resize-handle absolute top-0 left-0 h-full z-10 cursor-ew-resize"
        @mousedown.prevent="startResize"
      />

      <div class="pane-header flex items-center justify-between px-3 py-2 border-b shrink-0">
        <span class="pane-title text-xs font-semibold">Knowledge Graph</span>
        <div class="flex items-center gap-0.5">
          <button
            type="button"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline"
            title="Zoom in"
            @click="zoomIn"
          >
            <GIcon
              :name="GIconName.Plus"
              :size="13"
            />
          </button>
          <button
            type="button"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline"
            title="Zoom out"
            @click="zoomOut"
          >
            <GIcon
              :name="GIconName.Minus"
              :size="13"
            />
          </button>
          <button
            type="button"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline"
            title="Fit to view"
            @click="zoomFitGraph"
          >
            <GIcon
              :name="GIconName.Expand"
              :size="13"
            />
          </button>
          <button
            type="button"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline"
            title="Recenter"
            @click="recenterGraph"
          >
            <GIcon
              :name="GIconName.Crosshair"
              :size="13"
            />
          </button>
          <RouterLink
            to="/graph"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline"
            title="Fullscreen"
            @click="closePane"
          >
            <GIcon
              :name="GIconName.FrameCorners"
              :size="13"
            />
          </RouterLink>
          <button
            type="button"
            class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors no-underline ml-1"
            title="Close graph"
            @click="closePane"
          >
            <GIcon
              :name="GIconName.X"
              :size="14"
              weight="bold"
            />
          </button>
        </div>
      </div>

      <div class="flex-1 min-h-0 overflow-hidden flex flex-col">
        <KnowledgeGraph
          ref="graphReference"
          in-panel
        />
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import {
  ref, defineAsyncComponent, onUnmounted, useTemplateRef,
} from 'vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';

const KnowledgeGraph = defineAsyncComponent(() => import('@/components/KnowledgeGraph.vue'));

const open = ref(false);
const graphReference = useTemplateRef<InstanceType<typeof KnowledgeGraph>>('graphReference');

const MIN_WIDTH = 280;
const MAX_WIDTH = 900;
const paneWidth = ref(
  typeof window !== 'undefined'
    ? Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, Math.round(window.innerWidth * 0.5)))
    : 480,
);

let dragging = false;

function onMouseMove (event: MouseEvent) {
  if (!dragging) return;
  paneWidth.value = Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, window.innerWidth - event.clientX));
  window.dispatchEvent(new Event('resize'));
}

function startResize (_event: MouseEvent) {
  dragging = true;
  document.body.style.cursor = 'ew-resize';
  document.body.style.userSelect = 'none';
  window.addEventListener('mousemove', onMouseMove);
  window.addEventListener('mouseup', stopResize);
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

function close () {
  open.value = false;
}

function closePane () {
  open.value = false;
}

function recenterGraph () {
  graphReference.value?.recenter();
}

function show () {
  open.value = true;
}

function toggle () {
  open.value = !open.value;
}

function zoomFitGraph () {
  graphReference.value?.zoomFit();
}

function zoomIn () {
  graphReference.value?.zoomIn();
}

function zoomOut () {
  graphReference.value?.zoomOut();
}

defineExpose({
  show,
  close,
  toggle,
  open,
});
</script>

<style scoped>
.graph-pane {
  border-left: 1px solid var(--gui-neutral-border);
  background: var(--gui-neutral-bg);
  min-width: 280px;
  max-width: 900px;
}
.resize-handle {
  width: 5px;
}
.resize-handle:hover {
  background: oklch(0.6 0.15 250 / 0.25);
}
.pane-header {
  border-color: var(--gui-neutral-border);
}
.pane-title {
  color: var(--gui-neutral-fg-muted);
}
.ctrl-btn {
  color: var(--gui-neutral-solid);
}
.ctrl-btn:hover { color: var(--gui-neutral-fg); }
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
