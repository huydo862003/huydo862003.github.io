<template>
  <div
    ref="wrap"
    class="graph-wrap"
  >
    <div
      v-if="inView"
      class="scroll-nav"
    >
      <button
        class="scroll-btn"
        title="Exit graph (scroll up)"
        @click="scrollUp"
      >
        <PhCaretDoubleUp :size="14" />
      </button>
      <button
        class="scroll-btn"
        title="Skip to bottom"
        @click="scrollDown"
      >
        <PhCaretDoubleDown :size="14" />
      </button>
    </div>
    <div class="graph-header">
      <span class="graph-label">Knowledge Graph</span>
      <div class="controls">
        <button
          class="ctrl-btn"
          title="Zoom in"
          @click="zoomIn"
        >
          <PhPlus :size="13" />
        </button>
        <button
          class="ctrl-btn"
          title="Zoom out"
          @click="zoomOut"
        >
          <PhMinus :size="13" />
        </button>
        <button
          class="ctrl-btn"
          title="Fit to view"
          @click="zoomFit"
        >
          <PhArrowsOut :size="13" />
        </button>
        <button
          class="ctrl-btn"
          title="Recenter"
          @click="recenter"
        >
          <PhCrosshair :size="13" />
        </button>
        <router-link
          to="/graph"
          class="ctrl-btn"
          title="Fullscreen"
        >
          <PhFrameCorners :size="13" />
        </router-link>
      </div>
    </div>
    <div
      ref="container"
      class="graph-canvas"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, onMounted, onUnmounted,
} from 'vue';
import {
  PhPlus, PhMinus, PhArrowsOut, PhCrosshair, PhFrameCorners,
  PhCaretDoubleUp, PhCaretDoubleDown,
} from '@phosphor-icons/vue';
import { useGraph } from '@/composables/useGraph';

const wrap = ref<HTMLElement>();
const container = ref<HTMLElement>();
const inView = ref(false);

const {
  zoomIn, zoomOut, zoomFit, recenter,
} = useGraph(container, 700);

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
      { threshold: 0.1 },
    );
    observer.observe(wrap.value);
  }
});

onUnmounted(() => {
  observer?.disconnect();
});
</script>

<style scoped>
@reference "../style.css";
@reference "../style.css";
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
</style>
