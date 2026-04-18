<template>
  <div class="flex flex-col h-screen font-sans">
    <div class="flex flex-1 overflow-hidden">
      <!-- Sidebar with slide transition -->
      <div
        class="sidebar-panel"
        :class="{ 'sidebar-collapsed': !showSidebar }"
      >
        <ContentTree
          @select="openFile"
          @hide="showSidebar = false"
        />
      </div>

      <Splitpanes class="flex-1 min-w-0 overflow-hidden splitter-styled">
        <!-- Center: frontmatter + editor -->
        <Pane :size="45">
          <div class="flex flex-col h-full min-w-0">
            <div
              v-if="fileStore.loading"
              class="flex items-center justify-center h-full text-sm text-gray-500"
            >
              Loading…
            </div>
            <template v-else-if="fileStore.currentPath">
              <div class="flex flex-col flex-1 overflow-y-auto p-2">
                <FrontmatterForm
                  :frontmatter="frontmatter"
                  :schema="fileStore.currentSchema"
                  class="shrink-0"
                  @update="onFrontmatterUpdate"
                />
                <MarkdownEditor
                  :key="fileStore.currentPath"
                  v-model="bodyContent"
                  class="shrink-0"
                />
              </div>
            </template>
            <div
              v-else
              class="flex items-center justify-center h-full text-sm text-gray-500"
            >
              Select a file or create new content.
            </div>
          </div>
        </Pane>

      </Splitpanes>
    </div>

    <GitPanel>
      <!-- leading: back link, path, sidebar + preview + save toggles -->
      <template #leading>
        <router-link
          to="/"
          class="flex items-center gap-1 text-sm font-semibold text-blue-500 no-underline"
          title="Back to site"
        >
          <PhArrowLeft :size="14" />
        </router-link>
        <button
          class="icon-btn"
          :class="showSidebar ? 'active' : ''"
          title="Toggle sidebar"
          @click="showSidebar = !showSidebar"
        >
          <PhSidebar :size="14" />
        </button>
        <a
          v-if="previewUrl"
          class="icon-btn"
          :href="previewUrl"
          target="_blank"
          title="Open preview"
        >
          <PhEye :size="14" />
        </a>
        <button
          class="icon-btn"
          :disabled="!fileStore.dirty || fileStore.saving"
          :title="fileStore.saving ? 'Saving…' : fileStore.dirty ? 'Save (Ctrl+S)' : 'Saved'"
          @click="save"
        >
          <PhFloppyDisk :size="14" />
        </button>
        <span
          v-if="fileStore.currentPath"
          class="text-xs"
          :class="fileStore.saving ? 'text-amber-500' : fileStore.dirty ? 'text-gray-400' : 'text-emerald-500'"
        >
          {{ fileStore.saving ? 'Saving...' : fileStore.dirty ? 'Unsaved' : 'Saved' }}
        </span>
      </template>
    </GitPanel>
  </div>
</template>

<script setup lang="ts">
import {
  computed, onMounted, onUnmounted, ref, watch,
} from 'vue';
import {
  useRoute, useRouter,
} from 'vue-router';
import {
  PhArrowLeft, PhFloppyDisk, PhEye, PhSidebar,
} from '@phosphor-icons/vue';
import {
  Splitpanes, Pane,
} from 'splitpanes';
import 'splitpanes/dist/splitpanes.css';
import {
  useFileStore,
} from '../stores/file.store';
import {
  useTreeStore,
} from '../stores/tree.store';
import ContentTree from '../components/ContentTree.vue';
import MarkdownEditor from '../components/MarkdownEditor.vue';
import FrontmatterForm from '../components/FrontmatterForm.vue';
import GitPanel from '../components/GitPanel.vue';
import {
  parseFrontMatter,
} from '@/utils/content';

const showSidebar = ref(true);
const fileStore = useFileStore();
const treeStore = useTreeStore();
const route = useRoute();
const router = useRouter();

watch(() => fileStore.currentPath, (path) => {
  if (path) router.replace({ hash: `#${path}` });
});

watch(() => frontmatter.value, (fm) => {
  const title = fm?.title || fm?.question || fm?.name || 'Untitled';
  document.title = `Editor - ${title}`;
}, { immediate: true });

const previewUrl = computed(() => {
  const p = fileStore.currentPath;
  if (!p) return '';
  const slug = p.replace(/\.md$/, '').split('/').pop();
  const parts = p.split('/');
  const type = parts[0];
  // journey from frontmatter or from directory structure (e.g., concepts/plt/foo.md -> plt)
  const journey = (frontmatter.value.journey as string | undefined) || (parts.length >= 3 ? parts[1] : '');
  if (type === 'thoughts') return `/thoughts/${slug}`;
  if (type === 'journeys') return `/journeys/${slug}`;
  if (type === 'authors') return '';
  if (journey) {
    if (type === 'concepts') return `/journeys/${journey}/concepts/${slug}`;
    if (type === 'flashcards') return `/journeys/${journey}/flashcards/${slug}`;
    if (type === 'phases') return `/journeys/${journey}/phases/${slug}`;
    if (type === 'books') return `/journeys/${journey}/books/${slug}`;
    if (type === 'blogs') return `/journeys/${journey}/blogs/${slug}`;
    if (type === 'papers') return `/journeys/${journey}/papers/${slug}`;
  }
  return '';
});

// Parse frontmatter + body from raw content
const parsed = computed(() => parseFrontMatter(fileStore.content));
const frontmatter = computed(() => parsed.value.frontMatter);

const bodyContent = computed({
  get: () => parsed.value.rawContent,
  set: (newBody: string) => {
    fileStore.content = rebuildContent(frontmatter.value, newBody);
  },
});

function rebuildContent (fm: Record<string, unknown>, body: string): string {
  const lines: string[] = ['---'];
  for (const [
    key,
    val,
  ] of Object.entries(fm)) {
    lines.push(formatYamlLine(key, val));
  }
  lines.push('---');
  lines.push(body);
  return lines.join('\n');
}

function formatYamlLine (key: string, val: unknown): string {
  if (Array.isArray(val)) {
    if (val.length === 0) return `${key}: []`;
    return `${key}:\n${val.map((v) => `  - "${v}"`).join('\n')}`;
  }
  if (typeof val === 'boolean') return `${key}: ${val}`;
  if (typeof val === 'number') return `${key}: ${val}`;
  if (typeof val === 'string') return `${key}: "${val}"`;
  return `${key}: ${JSON.stringify(val)}`;
}

function onFrontmatterUpdate (key: string, value: unknown) {
  const newFm = {
    ...frontmatter.value,
    [key]: value,
  };
  fileStore.content = rebuildContent(newFm, parsed.value.rawContent);
}

// file open
let navigating = false;
async function openFile (path: string) {
  navigating = true;
  clearTimeout(autosaveTimer);
  await fileStore.openFile(path);
  navigating = false;
}

let saving = false;
async function save () {
  if (saving || navigating) return;
  saving = true;
  try { await fileStore.save(); }
  finally { saving = false; }
}

// autosave
let autosaveTimer: ReturnType<typeof setTimeout> | undefined;
watch(() => fileStore.content, () => {
  if (!fileStore.dirty || navigating || saving) return;
  clearTimeout(autosaveTimer);
  autosaveTimer = setTimeout(save, 2000);
});

// keyboard shortcut
function onKeydown (e: KeyboardEvent) {
  if ((e.ctrlKey || e.metaKey) && e.key === 's') {
    e.preventDefault();
    save();
  }
}

onUnmounted(() => {
  window.removeEventListener('keydown', onKeydown);
  clearTimeout(autosaveTimer);
});

function toRoute (pathMatch: string | string[]): string {
  return '/' + (Array.isArray(pathMatch) ? pathMatch.join('/') : pathMatch);
}

// resolve route on mount
onMounted(async () => {
  window.addEventListener('keydown', onKeydown);
  await treeStore.loadSchemas();

  const pathMatch = route.params.pathMatch;
  if (pathMatch) {
    await fileStore.openFromRoute(toRoute(pathMatch));
  } else if (route.hash) {
    await fileStore.openFile(route.hash.slice(1));
  }
});

watch(() => route.params.pathMatch, async (pathMatch) => {
  if (pathMatch) await fileStore.openFromRoute(toRoute(pathMatch));
});
</script>

<style scoped>
.sidebar-panel {
  width: 240px;
  flex-shrink: 0;
  overflow: hidden;
  transition: width 0.2s ease;
  border-right: 1px solid #e5e7eb;
}
.sidebar-collapsed {
  width: 0;
  border-right: none;
}

.icon-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 2rem;
  height: 2rem;
  border: 1px solid #e5e7eb;
  border-radius: 4px;
  background: white;
  cursor: pointer;
  flex-shrink: 0;
}
.icon-btn:hover { background: #f3f4f6; }
.icon-btn.active { background: #eff6ff; border-color: #93c5fd; color: #2563eb; }
.icon-btn:disabled { opacity: 0.5; cursor: not-allowed; }

/* splitter gap */
.splitter-styled :deep(.splitpanes__splitter) {
  width: 5px;
  background: #e5e7eb;
  margin: 0 2px;
}
.splitter-styled :deep(.splitpanes__splitter:hover) {
  background: #9ca3af;
}
</style>
