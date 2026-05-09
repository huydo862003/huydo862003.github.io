<template>
  <div class="kg-page flex flex-col h-screen">
    <div class="kg-page-toolbar flex items-center gap-4 px-4 h-10 shrink-0">
      <button
        type="button"
        class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors"
        title="Back"
        @click="goBack"
      >
        <GIcon
          :name="GIconName.ArrowLeft"
          :size="14"
        />
      </button>
      <span class="kg-page-info text-xs">{{ nodes.length }} nodes, {{ edges.length }} edges</span>
      <div class="flex items-center gap-1 ml-auto">
        <button
          type="button"
          class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors"
          title="Zoom in"
          @click="zoomIn"
        >
          <GIcon
            :name="GIconName.Plus"
            :size="14"
          />
        </button>
        <button
          type="button"
          class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors"
          title="Zoom out"
          @click="zoomOut"
        >
          <GIcon
            :name="GIconName.Minus"
            :size="14"
          />
        </button>
        <button
          type="button"
          class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors"
          title="Fit to view"
          @click="zoomFit"
        >
          <GIcon
            :name="GIconName.Expand"
            :size="14"
          />
        </button>
        <button
          type="button"
          class="ctrl-btn p-1.5 rounded-sm cursor-pointer transition-colors"
          title="Recenter"
          @click="recenter"
        >
          <GIcon
            :name="GIconName.Crosshair"
            :size="14"
          />
        </button>
      </div>
    </div>
    <div
      ref="container"
      class="flex-1"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, useTemplateRef,
} from 'vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  useRouter,
} from 'vue-router';
import {
  useGraph,
} from '@/composables/useGraph';
import {
  nodes, edges,
} from '@/utils/graph';
import {
  useSeo,
} from '@/composables/useSeo';

useSeo({
  title: ref('Knowledge Graph'),
  description: ref('An interactive graph of concepts, books, and connections from Scrambled Kitchen.'),
  path: ref('/graph'),
  type: 'website',
});

const router = useRouter();
const container = useTemplateRef<HTMLElement>('container');

function goBack () {
  router.back();
}

const graphHeight = computed(() => window.innerHeight - 40);

const {
  zoomIn, zoomOut, zoomFit, recenter,
} = useGraph(container, graphHeight);
</script>

<style scoped>
.kg-page {
  background: #141414;
  color: #d4d4d4;
}
.kg-page-toolbar {
  border-bottom: 1px solid #2a2a2a;
}
.kg-page-info {
  color: #666;
}
.ctrl-btn {
  color: #666;
}
.ctrl-btn:hover {
  color: #d4d4d4;
  background: #1c1c1c;
}
</style>
