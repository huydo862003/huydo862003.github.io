<template>
  <Transition name="fade">
    <div
      v-if="open"
      class="overlay"
      @click.self="$emit('close')"
    >
      <div class="modal detail">
        <div class="detail-header">
          <div class="detail-title-row">
            <h2>{{ title }}</h2>
            <span
              v-if="status"
              :class="['detail-badge', `status-${status}`]"
            >{{ status }}</span>
          </div>
          <button @click="$emit('close')">
            &times;
          </button>
        </div>
        <div class="detail-body">
          <slot />
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  open: boolean;
  title: string;
  status?: string;
}>(), { status: '' });

defineEmits<{
  close: [];
}>();
</script>

<style scoped>
@reference "../style.css";
.detail-title-row {
  @apply flex items-center gap-2 min-w-0;
}
.detail-badge {
  @apply text-xs px-1.5 py-0.5 rounded-sm bg-bg-subtle shrink-0;
}
.detail-body {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
}
</style>
