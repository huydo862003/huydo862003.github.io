<template>
  <GBreadcrumb>
    <GBreadcrumbItem
      v-for="crumb in resolvedCrumbs"
      :key="crumb.to"
      :as="RouterLink"
      :to="crumb.to"
    >
      <span class="text-xs inline-block max-w-32 overflow-hidden whitespace-nowrap text-ellipsis align-bottom">{{ crumb.label }}</span>
    </GBreadcrumbItem>
  </GBreadcrumb>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  RouterLink,
} from 'vue-router';
import {
  GBreadcrumb, GBreadcrumbItem,
} from '@hdnax/genuix';
import {
  useJourneyStore,
} from '@/stores/journeys';

const {
  crumbs,
} = defineProps<{
  /** The breadcrumb items to render */
  crumbs: {
    label: string;
    to: string;
  }[];
}>();

const journeyStore = useJourneyStore();

const resolvedCrumbs = computed(() =>
  crumbs.map((crumb) => {
    const journey = journeyStore.getBySlug(crumb.label);

    return {
      label: journey ? journey.title : crumb.label,
      to: crumb.to,
    };
  }));
</script>
