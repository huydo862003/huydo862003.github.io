<template>
  <nav class="breadcrumb">
    <router-link
      to="/"
      class="crumb"
    >
      Kitchen
    </router-link>
    <template v-if="resolved.length <= 3">
      <router-link
        v-for="crumb in resolved.slice(0, -1)"
        :key="crumb.to"
        :to="crumb.to"
        class="crumb"
      >
        <span class="sep">/</span>
        {{ crumb.label }}
      </router-link>
      <span
        v-if="resolved.length"
        class="here"
      >
        <span class="sep">/</span>
        <PhMapPinSimple :size="12" />
      </span>
    </template>
    <template v-else>
      <router-link
        :to="resolved[0].to"
        class="crumb"
      >
        <span class="sep">/</span>
        {{ resolved[0].label }}
      </router-link>
      <VDropdown :distance="4">
        <span class="crumb ellipsis">
          <span class="sep">/</span>
          &hellip;
        </span>
        <template #popper>
          <div class="dropdown-list">
            <router-link
              v-for="crumb in resolved.slice(1, -2)"
              :key="crumb.to"
              :to="crumb.to"
              class="dropdown-item"
            >
              {{ crumb.label }}
            </router-link>
          </div>
        </template>
      </VDropdown>
      <router-link
        :to="resolved[resolved.length - 2].to"
        class="crumb"
      >
        <span class="sep">/</span>
        {{ resolved[resolved.length - 2].label }}
      </router-link>
      <span class="crumb here">
        <span class="sep">/</span>
        <PhMapPinSimple :size="11" />
      </span>
    </template>
  </nav>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { PhMapPinSimple } from '@phosphor-icons/vue';
import { Dropdown as VDropdown } from 'floating-vue';
import { useJourneyStore } from '@/stores/journeys';

const props = defineProps<{
  crumbs: { label: string;
    to: string; }[];
}>();

const journeyStore = useJourneyStore();

const resolved = computed(() =>
  props.crumbs.map((c) => {
    const journey = journeyStore.getBySlug(c.label);
    return journey
      ? {
        ...c,
        label: journey.title,
      }
      : c;
  }));
</script>

<style scoped>
@reference "../../style.css";
@reference "../../style.css";
.breadcrumb {
  @apply flex flex-wrap items-center text-xs text-fg-faint;
}
.crumb {
  @apply no-underline text-fg-faint hover:text-accent-blue transition-colors
         truncate max-w-28 sm:max-w-40;
}
.here {
  @apply flex items-center text-fg-faint cursor-default shrink-0;
}
.ellipsis {
  @apply cursor-pointer max-w-none;
}
.sep {
  @apply mx-1 sm:mx-1.5 text-border;
}
.dropdown-list {
  @apply flex flex-col py-1;
}
.dropdown-item {
  @apply text-xs text-fg-muted no-underline px-3 py-1.5
         hover:bg-bg-subtle transition-colors;
}
</style>
