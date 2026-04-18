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
});

onUnmounted(async () => {
  await crepe?.destroy();
});
</script>

<style scoped>
@reference "tailwindcss";

.markdown-editor {
  @apply flex-1 min-h-0 overflow-visible relative;
}
.markdown-editor :deep(.milkdown) {
  @apply h-full overflow-y-auto overflow-x-hidden;
}
.markdown-editor :deep(.editor) {
  @apply py-4 pr-6 pl-4 outline-none min-h-full;
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
</style>
