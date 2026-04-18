import {
  defineStore,
} from 'pinia';
import {
  ref, computed,
} from 'vue';
import * as fileService from '../services/file.service';
import {
  useTreeStore,
} from './tree.store';

export const useFileStore = defineStore('file', () => {
  const currentPath = ref<string | undefined>(undefined);
  const originalContent = ref('');
  const content = ref('');
  const loading = ref(false);
  const saving = ref(false);

  const dirty = computed(() => content.value !== originalContent.value);

  const contentType = computed(() => {
    if (!currentPath.value) return undefined;
    return currentPath.value.split('/')[0];
  });

  const currentSchema = computed(() => {
    if (!contentType.value) return undefined;
    return useTreeStore().schemaFor(contentType.value);
  });

  async function openFile (path: string) {
    loading.value = true;
    try {
      const data = await fileService.openFile(path);
      currentPath.value = path;
      originalContent.value = data.content;
      content.value = data.content;
    } finally {
      loading.value = false;
    }
  }

  async function openFromRoute (route: string) {
    try {
      const path = await fileService.resolveFilepath(route);
      await openFile(path);
    } catch {
      // route couldn't be resolved
    }
  }

  async function save () {
    if (!currentPath.value || !dirty.value) return;
    saving.value = true;
    try {
      await fileService.updateFile(currentPath.value, content.value);
      originalContent.value = content.value;
    } finally {
      saving.value = false;
    }
  }

  return {
    currentPath,
    content,
    originalContent,
    loading,
    saving,
    dirty,
    contentType,
    currentSchema,
    openFile,
    openFromRoute,
    save,
  };
});
