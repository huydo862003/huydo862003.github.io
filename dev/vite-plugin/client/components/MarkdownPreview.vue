<template>
  <div class="markdown-preview">
    <div class="preview-header">
      Preview
    </div>
    <div
      class="preview-body prose"
      v-html="renderedHtml"
    />
  </div>
</template>

<script setup lang="ts">
import {
  ref, watch,
} from 'vue';
import {
  renderMarkdown, parseFrontMatter,
} from '@/utils/content';

const props = defineProps<{ content: string }>();
const renderedHtml = ref('');

let debounceTimer: ReturnType<typeof setTimeout>;

watch(() => props.content, (raw) => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(async () => {
    const {
      rawContent,
    } = parseFrontMatter(raw);
    renderedHtml.value = await renderMarkdown(rawContent);
  }, 300);
}, {
  immediate: true,
});
</script>

<style scoped>
.markdown-preview {
  height: 100%;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}
.preview-header {
  padding: 0.4rem 0.75rem;
  font-size: 0.8rem;
  font-weight: 600;
  border-bottom: 1px solid var(--border, #e5e7eb);
  color: var(--text-muted, #6b7280);
}
.preview-body {
  padding: 1rem;
  flex: 1;
  overflow-y: auto;
}
</style>
