<template>
  <div
    ref="wrap"
    :class="['graph-wrap', inPanel && 'graph-wrap--panel']"
  >
    <div
      v-if="inView && !inPanel"
      class="scroll-nav"
    >
      <button
        class="scroll-btn"
        title="Exit graph (scroll up)"
        @click="scrollUp"
      >
        <GIcon
          :name="GIconName.CaretDoubleUp"
          :size="14"
        />
      </button>
      <button
        class="scroll-btn"
        title="Skip to bottom"
        @click="scrollDown"
      >
        <GIcon
          :name="GIconName.CaretDoubleDown"
          :size="14"
        />
      </button>
    </div>
    <div
      v-if="!inPanel"
      class="graph-header"
    >
      <span class="graph-label">Knowledge Graph</span>
      <div class="controls">
        <button
          class="ctrl-btn"
          title="Zoom in"
          @click="zoomIn"
        >
          <GIcon
            :name="GIconName.Plus"
            :size="13"
          />
        </button>
        <button
          class="ctrl-btn"
          title="Zoom out"
          @click="zoomOut"
        >
          <GIcon
            :name="GIconName.Minus"
            :size="13"
          />
        </button>
        <button
          class="ctrl-btn"
          title="Fit to view"
          @click="zoomFit"
        >
          <GIcon
            :name="GIconName.Expand"
            :size="13"
          />
        </button>
        <button
          class="ctrl-btn"
          title="Recenter"
          @click="recenter"
        >
          <GIcon
            :name="GIconName.Crosshair"
            :size="13"
          />
        </button>
        <router-link
          to="/graph"
          class="ctrl-btn"
          title="Fullscreen"
        >
          <GIcon
            :name="GIconName.FrameCorners"
            :size="13"
          />
        </router-link>
      </div>
    </div>
    <div
      ref="container"
      :class="['graph-canvas', inPanel && 'graph-canvas--panel']"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, onMounted, onUnmounted,
} from 'vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  useGraph,
} from '@/composables/useGraph';

const {
  inPanel = false,
} = defineProps<{
  inPanel?: boolean;
}>();

const wrap = ref<HTMLElement>();
const container = ref<HTMLElement>();
const inView = ref(false);

// When embedded in the side panel the pane is 100svh; subtract the header (~36px)
const PANEL_HEADER_PX = 36;
const panelHeight = ref(typeof window !== 'undefined' ? window.innerHeight - PANEL_HEADER_PX : 664);
function updatePanelHeight () {
  panelHeight.value = window.innerHeight - PANEL_HEADER_PX;
}
if (inPanel && typeof window !== 'undefined') {
  window.addEventListener('resize', updatePanelHeight);
}

const graphHeight = computed(() => (inPanel ? panelHeight.value : 700));

const {
  zoomIn, zoomOut, zoomFit, recenter,
} = useGraph(container, graphHeight);

function scrollUp () {
  wrap.value?.scrollIntoView({
    behavior: 'smooth',
    block: 'end',
  });
  window.scrollBy({
    top: -window.innerHeight,
    behavior: 'smooth',
  });
}
function scrollDown () {
  document.documentElement.scrollTo({
    top: document.documentElement.scrollHeight,
    behavior: 'smooth',
  });
}

let observer: IntersectionObserver | undefined;

onMounted(() => {
  if (wrap.value) {
    observer = new IntersectionObserver(
      ([entry]) => {
        inView.value = entry.isIntersecting;
      },
      {
        threshold: 0.1,
      },
    );
    observer.observe(wrap.value);
  }
});

onUnmounted(() => {
  observer?.disconnect();
  if (inPanel) {
    window.removeEventListener('resize', updatePanelHeight);
  }
});

defineExpose({
  zoomIn,
  zoomOut,
  zoomFit,
  recenter,
});
</script>

<style scoped>
@reference "@/style.css";
.graph-wrap {
  @apply rounded-sm overflow-hidden relative;
  background: #141414;
}
.scroll-nav {
  @apply absolute z-10 flex flex-col gap-0.5;
  right: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
}
.scroll-btn {
  @apply flex items-center justify-center w-7 h-7 rounded-sm cursor-pointer transition-colors;
  background: rgba(255, 255, 255, 0.08);
  color: #999;
}
.scroll-btn:hover {
  background: rgba(255, 255, 255, 0.18);
  color: #d4d4d4;
}
.graph-header {
  @apply flex items-center justify-between px-4 py-2;
  border-bottom: 1px solid #2a2a2a;
}
.graph-label {
  @apply text-xs;
  color: #666;
}
.controls {
  @apply flex items-center gap-0.5;
}
.ctrl-btn {
  @apply p-1.5 rounded-sm cursor-pointer transition-colors no-underline;
  color: #666;
}
.ctrl-btn:hover {
  color: #d4d4d4;
  background: #1c1c1c;
}
.graph-canvas {
  height: 700px;
}
.graph-wrap--panel {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
}
.graph-canvas--panel {
  flex: 1;
  min-height: 0;
}
</style>
