<template>
  <div class="min-h-screen flex flex-col">
    <NavBar
      v-if="!isGraph && !isEditor"
      @open-palette="openPalette"
    />
    <div class="flex flex-row flex-1">
      <main :class="isGraph ? '' : 'flex-1'">
        <RouterView
          v-slot="{
            Component,
          }"
        >
          <Transition
            name="page"
            mode="out-in"
          >
            <component
              :is="Component"
              :key="$route.path"
            />
          </Transition>
        </RouterView>
      </main>
      <GraphSidePanel ref="graphPanel" />
    </div>
    <FooterBar v-if="!isGraph && !isEditor" />
    <CommandPalette
      ref="palette"
      @open-graph-side="toggleGraphPanel"
    />
  </div>
</template>

<script setup lang="ts">
import {
  computed, defineAsyncComponent, useTemplateRef,
} from 'vue';
import {
  useRouter,
} from 'vue-router';
import NavBar from '@/components/layout/NavBar.vue';
import FooterBar from '@/components/layout/FooterBar.vue';
import {
  useKeyboard,
} from '@/composables/useKeyboard';
import GraphSidePanel from '@/components/GraphSidePanel.vue';

const CommandPalette = defineAsyncComponent(() => import('@/components/CommandPalette.vue'));

const palette = useTemplateRef<InstanceType<typeof CommandPalette>>('palette');
const graphPanel = useTemplateRef<InstanceType<typeof GraphSidePanel>>('graphPanel');
const router = useRouter();
const {
  register,
} = useKeyboard();

const isGraph = computed(() => router.currentRoute.value.path === '/graph');
const isEditor = computed(() => {
  const path = router.currentRoute.value.path;

  return path === '/edit' || path.endsWith('/edit');
});

function go (path: string) {
  palette.value?.close();
  if (router.currentRoute.value.path === path) {
    router.back();
  } else {
    router.push(path);
  }
}

function openPalette () {
  palette.value?.show();
}

function toggleGraphPanel () {
  graphPanel.value?.toggle();
}

register([
  {
    key: 'p',
    alt: true,
    handler: () => palette.value?.show(),
    label: 'Search',
    scope: 'global',
  },
  {
    key: 'h',
    alt: true,
    handler: () => go('/'),
    label: 'Go to Home',
    scope: 'global',
  },
  {
    key: 't',
    alt: true,
    handler: () => go('/thoughts'),
    label: 'Go to Thoughts',
    scope: 'global',
  },
  {
    key: 'j',
    alt: true,
    handler: () => go('/journeys'),
    label: 'Go to Journeys',
    scope: 'global',
  },
  {
    key: 'g',
    alt: true,
    handler: () => go('/graph'),
    label: 'Go to Graph',
    scope: 'global',
  },
]);
</script>

<style scoped>
.page-enter-active {
  transition: opacity 0.1s ease, transform 0.1s ease;
}
.page-leave-active {
  transition: opacity 0.05s ease;
}
.page-enter-from {
  opacity: 0;
  transform: translateY(4px);
}
.page-leave-to {
  opacity: 0;
}
</style>
