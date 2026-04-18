<template>
  <div class="git-panel">
    <div
      v-if="$slots.leading"
      class="git-leading"
    >
      <slot name="leading" />
    </div>
    <div class="git-group">
      <VTooltip placement="top">
        <button
          class="btn-sm"
          :disabled="gitStore.loading"
          @click="refresh"
        >
          <PhArrowClockwise :size="14" />
        </button>
        <template #popper>Refresh status</template>
      </VTooltip>
      <div
        v-if="gitStore.files.length"
        class="git-changes"
      >
        <button
          class="git-badge"
          @click="showFiles = !showFiles"
        >
          {{ gitStore.files.length }} changed <PhCaretUp
            :size="10"
            :class="showFiles ? 'rotate-180' : ''"
            style="transition: transform 0.15s"
          />
        </button>
        <div
          v-if="showFiles"
          class="git-dropdown"
        >
          <ul class="git-file-list">
            <li
              v-for="f in gitStore.files"
              :key="f.path"
            >
              <code>{{ f.status }}</code> {{ f.path }}
            </li>
          </ul>
        </div>
      </div>
      <div class="git-divider" />
      <input
        v-model="commitMsg"
        class="git-input"
        placeholder="Commit message…"
        @keydown.enter="commit"
      >
      <VTooltip placement="top">
        <button
          class="btn-commit"
          :disabled="!commitMsg.trim() || committing"
          @click="commit"
        >
          <PhGitCommit :size="14" />
        </button>
        <template #popper>{{ committing ? 'Committing…' : 'Commit' }}</template>
      </VTooltip>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  ref, onMounted,
} from 'vue';
import {
  PhArrowClockwise, PhGitCommit, PhCaretUp,
} from '@phosphor-icons/vue';
import {
  Tooltip as VTooltip,
} from 'floating-vue';
import {
  useGitStore,
} from '../stores/git.store';

const gitStore = useGitStore();
const commitMsg = ref('');
const committing = ref(false);
const showFiles = ref(false);

async function refresh () {
  await gitStore.loadStatus();
}

async function commit () {
  if (!commitMsg.value.trim()) return;
  committing.value = true;
  try {
    await gitStore.commit(commitMsg.value);
    commitMsg.value = '';
  } finally {
    committing.value = false;
  }
}

onMounted(() => gitStore.loadStatus());
</script>

<style scoped>
.git-panel {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.4rem 0.75rem;
  border-top: 1px solid #e5e7eb;
  background: #f9fafb;
  font-size: 0.85rem;
  gap: 0.5rem;
}
.git-leading {
  display: flex;
  align-items: center;
  gap: 0.4rem;
}
.git-divider {
  width: 1px;
  height: 1.25rem;
  background: #e5e7eb;
  flex-shrink: 0;
}
.git-group {
  display: flex;
  align-items: center;
  gap: 0.4rem;
}
.git-changes {
  position: relative;
}
.git-badge {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  background: #fef3c7;
  color: #92400e;
  border: none;
  padding: 0.1rem 0.5rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 600;
  cursor: pointer;
}
.git-badge:hover { background: #fde68a; }
.git-dropdown {
  position: absolute;
  bottom: calc(100% + 6px);
  left: 0;
  background: white;
  border: 1px solid #e5e7eb;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  min-width: 240px;
  z-index: 100;
}
.git-file-list {
  list-style: none;
  padding: 0.4rem 0;
  margin: 0;
  font-size: 0.8rem;
  max-height: 200px;
  overflow-y: auto;
}
.git-file-list li {
  padding: 0.25rem 0.75rem;
  white-space: nowrap;
}
.git-file-list li:hover { background: #f9fafb; }
.git-file-list code {
  color: #dc2626;
  margin-right: 0.3rem;
}
.git-input {
  flex: 1;
  padding: 0.3rem 0.5rem;
  border: 1px solid var(--border, #e5e7eb);
  border-radius: 4px;
  font-size: 0.85rem;
}
.btn-sm {
  background: none;
  border: 1px solid var(--border, #e5e7eb);
  border-radius: 4px;
  cursor: pointer;
  padding: 0.2rem 0.5rem;
  font-size: 0.8rem;
}
.btn-sm:hover { background: var(--bg-hover, #f3f4f6); }
.btn-commit {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 2rem;
  height: 2rem;
  background: #2563eb;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.85rem;
  flex-shrink: 0;
}
.btn-commit:hover { background: #1d4ed8; }
.btn-commit:disabled { opacity: 0.5; cursor: not-allowed; }
</style>
