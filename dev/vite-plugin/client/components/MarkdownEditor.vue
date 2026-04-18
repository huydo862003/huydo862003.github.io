<template>
  <div
    ref="editorEl"
    class="markdown-editor"
  />
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { Crepe, CrepeFeature } from '@milkdown/crepe';
import '@milkdown/crepe/theme/common/prosemirror.css';
import '@milkdown/crepe/theme/common/reset.css';
import '@milkdown/crepe/theme/common/block-edit.css';
import '@milkdown/crepe/theme/common/code-mirror.css';
import '@milkdown/crepe/theme/common/cursor.css';
import '@milkdown/crepe/theme/common/image-block.css';
import '@milkdown/crepe/theme/common/link-tooltip.css';
import '@milkdown/crepe/theme/common/list-item.css';
import '@milkdown/crepe/theme/common/placeholder.css';
import '@milkdown/crepe/theme/common/toolbar.css';
import '@milkdown/crepe/theme/common/table.css';
import '@milkdown/crepe/theme/common/latex.css';
import '@milkdown/crepe/theme/frame.css';

const model = defineModel<string>({ required: true });

const editorEl = ref<HTMLElement>();
let crepe: Crepe | undefined;
let updating = false;

onMounted(async () => {
  if (!editorEl.value) return;

  crepe = new Crepe({
    root: editorEl.value,
    defaultValue: model.value,
    features: {
      [CrepeFeature.CodeMirror]: true,
      [CrepeFeature.Latex]: true,
      [CrepeFeature.Toolbar]: true,
      [CrepeFeature.BlockEdit]: true,
      [CrepeFeature.Placeholder]: true,
      [CrepeFeature.LinkTooltip]: true,
      [CrepeFeature.ImageBlock]: true,
      [CrepeFeature.ListItem]: true,
      [CrepeFeature.Table]: true,
      [CrepeFeature.Cursor]: true,
    },
    featureConfigs: {
      [CrepeFeature.Latex]: {
        katexOptions: { throwOnError: false, strict: false, trust: true },
      },
      [CrepeFeature.Placeholder]: {
        text: 'Start writing...',
      },
    },
  });

  crepe.on((api) => {
    api.markdownUpdated((_ctx, md) => {
      if (!updating) model.value = md;
    });
  });

  await crepe.create();

  // render <details><summary> as interactive toggle lists
  renderDetailsBlocks();
  let detailsTimer: ReturnType<typeof setTimeout> | undefined;
  crepe.on((api) => {
    api.markdownUpdated(() => {
      clearTimeout(detailsTimer);
      detailsTimer = setTimeout(renderDetailsBlocks, 300);
    });
  });
});

function renderDetailsBlocks () {
  if (!editorEl.value) return;
  const htmlBlocks = editorEl.value.querySelectorAll('[data-node-type="html"] , .html_block');
  for (const block of htmlBlocks) {
    const text = block.textContent ?? '';
    if (!text.includes('<details>') && !text.includes('<summary>')) continue;
    // already rendered
    if (block.querySelector('details')) continue;
    const wrapper = document.createElement('div');
    wrapper.innerHTML = text;
    const details = wrapper.querySelector('details');
    if (!details) continue;
    details.classList.add('cm-toggle');
    block.innerHTML = '';
    block.appendChild(details);
  }
}

onUnmounted(async () => {
  await crepe?.destroy();
});
</script>

<style scoped>
@reference "tailwindcss";

.markdown-editor {
  @apply overflow-visible relative;
}
.markdown-editor :deep(.milkdown) {
  @apply overflow-visible;
}
.markdown-editor :deep(.editor) {
  @apply py-4 pr-6 pl-20 outline-none min-h-full text-sm;
}
.markdown-editor :deep(.milkdown-block-handle) {
  @apply overflow-visible;
}
.markdown-editor :deep(.tableWrapper td),
.markdown-editor :deep(.tableWrapper th) {
  @apply relative;
}
.markdown-editor :deep(.tableWrapper .selectedCell) {
  @apply bg-blue-100;
}
.markdown-editor :deep(.tableWrapper td p),
.markdown-editor :deep(.tableWrapper th p) {
  visibility: visible !important;
  opacity: 1 !important;
}
.markdown-editor :deep(.cm-toggle) {
  @apply border border-gray-200 rounded-md my-2;
}
.markdown-editor :deep(.cm-toggle summary) {
  @apply px-3 py-2 cursor-pointer font-medium text-sm list-none;
}
.markdown-editor :deep(.cm-toggle summary::marker),
.markdown-editor :deep(.cm-toggle summary::-webkit-details-marker) {
  display: none;
}
.markdown-editor :deep(.cm-toggle summary::before) {
  content: '▶';
  @apply mr-2 text-xs text-gray-400 inline-block;
  transition: transform 0.15s;
}
.markdown-editor :deep(.cm-toggle[open] summary::before) {
  transform: rotate(90deg);
}
.markdown-editor :deep(.cm-toggle > :not(summary)) {
  @apply px-3 pb-2 text-sm;
}
</style>
