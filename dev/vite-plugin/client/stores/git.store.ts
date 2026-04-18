import {
  defineStore,
} from 'pinia';
import {
  ref,
} from 'vue';
import type {
  GitFile,
} from '../services/git.service';
import * as gitService from '../services/git.service';

export const useGitStore = defineStore('git', () => {
  const files = ref<GitFile[]>([]);
  const loading = ref(false);

  async function loadStatus () {
    loading.value = true;
    try {
      files.value = await gitService.loadStatus();
    } finally {
      loading.value = false;
    }
  }

  async function commit (message: string) {
    await gitService.commit(message);
    await loadStatus();
  }

  return {
    files,
    loading,
    loadStatus,
    commit,
  };
});
