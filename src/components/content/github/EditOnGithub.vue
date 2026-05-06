<template>
  <a
    :href="editUrl"
    target="_blank"
    rel="noopener"
    class="edit-link"
  >
    <GIcon
      :name="GIconName.PencilSimple"
      :size="14"
    />
    Edit on GitHub
  </a>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  GIcon, GIconName,
} from '@hdnax/genuix';

const props = defineProps<{
  path: string;
}>();

const editUrl = computed(() =>
  `https://github.com/huydo862003/huydo862003.github.io/edit/main/${props.path}`);
</script>

<style scoped>
@reference "@/style.css";
.edit-link {
  @apply inline-flex items-center gap-1 text-xs no-underline transition-colors;
  color: var(--gui-neutral-solid);
  &:hover { color: var(--gui-neutral-fg-muted); }
}
</style>
