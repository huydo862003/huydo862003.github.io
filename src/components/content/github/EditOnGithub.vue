<template>
  <a
    :href="editUrl"
    target="_blank"
    rel="noopener"
    class="edit-link"
  >
    <PhPencilSimple :size="14" />
    Edit on GitHub
  </a>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  PhPencilSimple,
} from '@phosphor-icons/vue';

const props = defineProps<{
  path: string;
}>();

const editUrl = computed(() =>
  `https://github.com/huydo862003/huydo862003.github.io/edit/main/${props.path}`);
</script>

<style scoped>
@reference "../../../style.css";
@reference "../../../style.css";
.edit-link {
  @apply inline-flex items-center gap-1 text-xs text-fg-faint no-underline
         hover:text-fg-muted transition-colors;
}
</style>
