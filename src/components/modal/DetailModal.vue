<template>
  <Transition name="fade">
    <div
      v-if="open"
      class="overlay"
      @click.self="$emit('close')"
    >
      <div class="modal detail">
        <div class="detail-header">
          <div class="flex items-center gap-2 min-w-0">
            <h2>{{ title }}</h2>
            <span
              v-if="status"
              :class="['text-xs px-1.5 py-0.5 rounded-sm modal-status-bg shrink-0', `status-${status}`]"
            >{{ status }}</span>
          </div>
          <GButton
            :prominence="GButtonProminence.Ghost"
            :size="GButtonSize.Xs"
            @click="$emit('close')"
          >
            &times;
          </GButton>
        </div>
        <div class="detail-body">
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
  open: boolean;
  title: string;
  status?: string;
}>();

defineEmits<{
  close: [];
}>();
</script>

<style scoped>
@reference "@/style.css";
.modal-status-bg {
  background-color: var(--gui-neutral-bg-subtle);
}
.detail-body {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
}
</style>
