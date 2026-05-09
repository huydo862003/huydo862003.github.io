<template>
  <div
    ref="wrap"
    class="kg-wrap rounded-sm overflow-hidden relative"
    :class="[inPanel && 'flex-1 min-h-0 flex flex-col']"
  >
    <div
      v-if="inView && !inPanel"
      class="kg-scroll-controls absolute z-10 flex flex-col gap-0.5"
    >
      <button
        type="button"
        class="scroll-btn flex items-center justify-center w-7 h-7 rounded-sm cursor-pointer transition-colors"
        title="Exit graph (scroll up)"
        @click="scrollUp"
      >
        <GIcon
          :name="GIconName.CaretDoubleUp"
          :size="14"
        />
      </button>
      <button
        type="button"
        class="scroll-btn flex items-center justify-center w-7 h-7 rounded-sm cursor-pointer transition-colors"
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
      class="kg-toolbar flex items-center justify-between px-4 py-2"
    >
      <span class="kg-toolbar-title text-xs">Knowledge Graph</span>
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
          @click="zoomFit"
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
          @click="recenter"
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
        >
          <GIcon
            :name="GIconName.FrameCorners"
            :size="13"
          />
        </RouterLink>
      </div>
    </div>
    <div
      ref="container"
      class="kg-container"
      :class="[inPanel ? 'flex-1 min-h-0' : 'kg-container-fixed']"
    />
  </div>
</template>

<script setup lang="ts">
import {
  computed, onMounted, onUnmounted, useTemplateRef,
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
  /** Whether the graph is rendered inside a side panel */
  inPanel?: boolean;
}>();

const wrap = useTemplateRef<HTMLElement>('wrap');
const container = useTemplateRef<HTMLElement>('container');
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

function scrollDown () {
  document.documentElement.scrollTo({
    top: document.documentElement.scrollHeight,
    behavior: 'smooth',
  });
}

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
.kg-wrap {
  background: #141414;
}
.kg-scroll-controls {
  right: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
}
.scroll-btn {
  background: rgba(255, 255, 255, 0.08);
  color: #999;
}
.scroll-btn:hover {
  background: rgba(255, 255, 255, 0.18);
  color: #d4d4d4;
}
.kg-toolbar {
  border-bottom: 1px solid #2a2a2a;
}
.kg-toolbar-title {
  color: #666;
}
.ctrl-btn {
  color: #666;
}
.ctrl-btn:hover {
  color: #d4d4d4;
  background: #1c1c1c;
}
.kg-container-fixed {
  height: 700px;
}
</style>
