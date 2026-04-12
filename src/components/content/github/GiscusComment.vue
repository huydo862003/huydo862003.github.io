<template>
  <div
    ref="container"
    class="giscus-wrap"
  />
</template>

<script setup lang="ts">
import {
  ref, onMounted, watch, computed,
} from 'vue';
import {
  useRoute,
} from 'vue-router';
import {
  useThemeStore,
} from '@/stores/theme';

const container = ref<HTMLElement>();
const route = useRoute();
const themeStore = useThemeStore();
const dark = computed(() => themeStore.isDark);

function load () {
  if (!container.value) return;
  container.value.innerHTML = '';

  const script = document.createElement('script');
  script.src = 'https://giscus.app/client.js';
  script.setAttribute('data-repo', 'huydo862003/huydo862003.github.io');
  script.setAttribute('data-repo-id', 'R_kgDORy3hLQ');
  script.setAttribute('data-category', 'General');
  script.setAttribute('data-category-id', 'DIC_kwDORy3hLc4C5di1');
  script.setAttribute('data-mapping', 'pathname');
  script.setAttribute('data-strict', '1');
  script.setAttribute('data-reactions-enabled', '1');
  script.setAttribute('data-emit-metadata', '1');
  script.setAttribute('data-input-position', 'top');
  script.setAttribute('data-theme', dark.value ? 'dark' : 'light');
  script.setAttribute('data-lang', 'en');
  script.setAttribute('data-loading', 'lazy');
  script.crossOrigin = 'anonymous';
  script.async = true;
  container.value.appendChild(script);
}

function updateTheme () {
  const iframe = container.value?.querySelector<HTMLIFrameElement>('iframe.giscus-frame');
  if (iframe) {
    iframe.contentWindow?.postMessage(
      {
        giscus: {
          setConfig: {
            theme: dark.value ? 'dark' : 'light',
          },
        },
      },
      'https://giscus.app',
    );
  }
}

onMounted(load);
watch(() => route.path, load);
watch(dark, updateTheme);
</script>

<style scoped>
@reference "../../../style.css";
@reference "../../../style.css";
.giscus-wrap {
  @apply mt-16 border-t border-border pt-8;
}
</style>
