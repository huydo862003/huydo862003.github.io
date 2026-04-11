<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/papers`"
        class="back"
      >
        &larr; back to papers
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Papers', to: `/journeys/${slug}/papers` }]" />
    </div>

    <template v-if="paper">
      <h1>{{ paper.title }}</h1>

      <div class="meta">
        <span
          v-if="paper.authors.length"
          class="authors"
        >{{ paper.authors.join(', ') }}</span>
        <template v-if="paper.venue || paper.year">
          <span class="sep">&middot;</span>
          <span
            v-if="paper.venue"
            class="venue"
          >{{ paper.venue }}</span>
          <span
            v-if="paper.year"
            class="year"
          >{{ paper.year }}</span>
        </template>
        <span :class="`status-${paper.status} ml-auto`">{{ paper.status }}</span>
      </div>

      <div
        v-if="paper.url"
        class="external-link-row"
      >
        <a
          :href="paper.url"
          target="_blank"
          rel="noopener"
          class="external-link"
        >
          <PhArrowSquareOut :size="13" /> Read paper
        </a>
      </div>

      <div
        v-if="paper.tags.length"
        class="tags"
      >
        <span
          v-for="t in paper.tags"
          :key="t"
          class="tag"
        >{{ t }}</span>
      </div>

      <div class="section">
        <h3 class="section-label">
          Notes
        </h3>
        <div
          v-if="content"
          class="prose"
          v-html="content"
        />
        <p
          v-else
          class="empty"
        >
          No notes yet.
        </p>
      </div>
    </template>
    <template v-else>
      <p>Not found. <router-link :to="`/journeys/${slug}/papers`">Back to papers</router-link></p>
    </template>
  </div>
</template>

<script setup lang="ts">
import { computed, watch } from 'vue';
import { useAsyncState } from '@vueuse/core';
import { useRoute } from 'vue-router';
import { PhArrowSquareOut } from '@phosphor-icons/vue';
import { useSeo } from '@/composables/useSeo';
import { usePaperStore } from '@/stores/papers';
import { loadContent } from '@/utils/content';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const paperSlug = computed(() => route.params.paperSlug as string);
const paperStore = usePaperStore();

const paper = computed(() => paperStore.getBySlug(paperSlug.value));

useSeo({
  title: computed(() => paper.value?.title),
  description: computed(() => paper.value?.authors.length ? `By ${paper.value.authors.join(', ')}` : undefined),
  path: computed(() => `/journeys/${slug.value}/papers/${paperSlug.value}`),
});

const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => paper.value ? loadContent(paper.value.slug) : '', '');
watch(paper, () => reloadContent());
</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold mb-2;
}
.meta {
  @apply flex flex-wrap items-center gap-x-2 gap-y-0.5 mb-3 text-xs text-fg-faint;
}
.sep {
  @apply text-fg-faint/50;
}
.external-link-row {
  @apply mb-4;
}
.external-link {
  @apply inline-flex items-center gap-1 text-xs text-accent-blue no-underline hover:underline;
}
.tags {
  @apply flex flex-wrap gap-1 mb-6;
}
.tag {
  @apply text-fg-faint border border-border rounded-sm px-1.5;
  font-size: 0.625rem;
  line-height: 1.25rem;
}
.section {
  @apply mb-6;
}
.section-label {
  @apply text-xs font-semibold text-fg-faint uppercase tracking-wider mb-3 pb-1 border-b border-border;
}
.empty {
  @apply text-sm text-fg-faint;
}
</style>
