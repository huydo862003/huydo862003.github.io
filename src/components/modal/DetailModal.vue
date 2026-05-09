<template>
  <Transition name="fade">
    <div
      v-if="open"
      class="overlay"
      @click.self="emitClose"
    >
      <div class="modal detail">
        <div class="detail-header">
          <div class="flex items-center gap-2 min-w-0">
            <h2>{{ title }}</h2>
            <span
              v-if="status"
              class="detail-status text-xs px-1.5 py-0.5 rounded-sm shrink-0"
              :class="[`status-${status}`]"
            >{{ status }}</span>
          </div>
          <GButton
            :prominence="GButtonProminence.Ghost"
            :size="GButtonSize.Xs"
            @click="emitClose"
          >
            &times;
          </GButton>
        </div>
        <div class="detail-body flex-1 overflow-y-auto min-h-0">
          <slot />
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import {
  GButton, GButtonProminence, GButtonSize,
} from '@hdnax/genuix';

const {
  open, title, status = '',
} = defineProps<{
  /** Whether the modal is open */
  open: boolean;
  /** The modal title */
  title: string;
  /** Optional status badge text */
  status?: string;
}>();

const emit = defineEmits<{
  close: [];
}>();

function emitClose () {
  emit('close');
}
</script>

<style scoped>
.detail-status {
  background-color: var(--gui-neutral-bg-subtle);
}
</style>
