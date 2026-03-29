<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/flashcards?mode=table&deck=${card?.deck ?? ''}`"
        class="back"
      >
        &larr; back to {{ card ? formatSlug(card.deck) + ' deck' : 'flashcards' }}
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Flashcards', to: `/journeys/${slug}/flashcards` }]" />
    </div>

    <template v-if="card">
      <h1 class="question">
        {{ card.question }}
      </h1>
      <p class="deck">
        {{ formatSlug(card.deck) }}
      </p>

      <div class="actions">
        <button
          class="btn btn-wrong"
          @click="flashcardStore.reviewCard(card.slug, false)"
        >
          Wrong
        </button>
        <button
          :class="['btn', reviewedToday ? 'btn-right-done' : 'btn-right']"
          :disabled="reviewedToday"
          @click="flashcardStore.reviewCard(card.slug, true)"
        >
          {{ reviewedToday ? 'Reviewed' : 'Right' }}
        </button>
        <span class="actions-meta">
          <span
            class="status-ring"
            :style="{ '--progress': masteryProgress, '--ring-color': ringColor(masteryProgress) }"
          />
          {{ masteryLabel }} &middot; {{ state.interval }}d
        </span>
      </div>

      <div
        class="card-review"
        @click="flipped = !flipped"
      >
        <Transition
          name="flip"
          mode="out-in"
        >
          <div
            v-if="!flipped"
            key="front"
            class="card-side"
          >
            <div class="card-label">
              question
            </div>
            <div class="card-text">
              {{ card.question }}
            </div>
            <details
              v-if="card.concepts.length || resolvedBooks.length"
              class="hint"
              @click.stop
            >
              <summary class="hint-toggle">
                <PhCaretRight
                  :size="10"
                  class="hint-icon"
                />
                Hint
              </summary>
              <div class="hint-list">
                <router-link
                  v-for="c in card.concepts"
                  :key="c"
                  :to="`/journeys/${slug}/concepts/${c}`"
                  class="hint-link"
                >
                  <PhBrain :size="12" />
                  {{ conceptStore.getBySlug(c)?.title ?? formatSlug(c) }}
                </router-link>
                <router-link
                  v-for="b in resolvedBooks"
                  :key="b.slug"
                  :to="`/journeys/${slug}/books/${b.slug}`"
                  class="hint-link"
                >
                  <PhBook :size="12" />
                  {{ b.title }}
                </router-link>
              </div>
            </details>
          </div>
          <div
            v-else
            key="back"
            class="card-side"
          >
            <div class="card-label">
              answer
            </div>
            <div
              v-if="answer"
              class="card-text prose"
              v-html="answer"
            />
            <p
              v-else
              class="card-text empty"
            >
              No answer yet.
            </p>
          </div>
        </Transition>
      </div>

      <ResourcePagination
        kind="flashcard"
        :prev="prevCard"
        :next="nextCard"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link :to="`/journeys/${slug}/flashcards`">
          Back to flashcards
        </router-link>
      </p>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch, defineAsyncComponent,
} from 'vue';
import { useAsyncState } from '@vueuse/core';
import { useRoute } from 'vue-router';
import {
  PhBrain, PhBook, PhCaretRight,
} from '@phosphor-icons/vue';
import { useSeo } from '@/composables/useSeo';
import { useFlashcardStore } from '@/stores/flashcards';
import {
  renderMarkdown, loadContent,
} from '@/utils/content';
import {
  formatSlug, ringColor,
} from '@/utils/format';
import { MASTERED_INTERVAL_DAYS } from '@/utils/sm2';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useConceptStore } from '@/stores/concepts';
import { useBookStore } from '@/stores/books';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const cardSlug = computed(() => route.params.cardSlug as string);
const flashcardStore = useFlashcardStore();
const conceptStore = useConceptStore();
const bookStore = useBookStore();

const card = computed(() => flashcardStore.cards.find((c) => c.slug === cardSlug.value));

useSeo({
  title: computed(() => card.value?.question),
  description: computed(() => card.value ? `Flashcard from ${card.value.deck} deck` : undefined),
  path: computed(() => `/journeys/${slug.value}/flashcards/${cardSlug.value}`),
});
const flipped = ref(false);
watch(cardSlug, () => {
  flipped.value = false;
});

const journeyCards = computed(() => {
  const slugs = conceptStore.getByJourney(slug.value).map((c) => c.slug);
  return flashcardStore.getByJourney(slugs);
});
const currentIdx = computed(() => journeyCards.value.findIndex((c) => c.slug === cardSlug.value));
const prevCard = computed(() => {
  const c = journeyCards.value[currentIdx.value - 1];
  return c && {
    to: `/journeys/${slug.value}/flashcards/${c.slug}`,
    title: c.question,
  };
});
const nextCard = computed(() => {
  const c = journeyCards.value[currentIdx.value + 1];
  return c && {
    to: `/journeys/${slug.value}/flashcards/${c.slug}`,
    title: c.question,
  };
});
const state = computed(() => flashcardStore.getState(cardSlug.value));
const reviewedToday = computed(() => {
  const d = state.value.lastReviewedAt;
  return d === new Date().toISOString()
    .slice(0, 10) && 1 <= state.value.repetitions;
});

const {
  state: answer, execute: reloadAnswer,
} = useAsyncState(async () => {
  if (!card.value) return '';
  const body = await loadContent(card.value.slug);
  if (body) return body;
  return card.value.answer && card.value.answer !== 'TODO' ? await renderMarkdown(card.value.answer) : '';
}, '');
watch(card, () => reloadAnswer());

const masteryProgress = computed(() => {
  const s = state.value;
  if (MASTERED_INTERVAL_DAYS <= s.interval) return '100';
  if (3 <= s.repetitions) return '60';
  if (1 <= s.repetitions) return '30';
  return '0';
});

const masteryLabel = computed(() => {
  const s = state.value;
  if (MASTERED_INTERVAL_DAYS <= s.interval) return 'Mastered';
  if (3 <= s.repetitions) return 'Reviewing';
  if (1 <= s.repetitions) return 'Learning';
  return 'New';
});

const resolvedBooks = computed(() =>
  (card.value?.books ?? [])
    .map((s) => bookStore.getBySlug(s))
    .filter((b): b is NonNullable<typeof b> => !!b));
</script>

<style scoped>
@reference "../../../style.css";
.question {
  @apply text-xl font-bold mb-1;
}
.deck {
  @apply text-xs text-fg-faint mb-5;
}
.card-review {
  @apply border border-border rounded-sm p-4 sm:p-6 cursor-pointer mb-4;
  perspective: 800px;
}
.card-label {
  @apply text-xs text-fg-faint mb-4;
}
.actions-meta {
  @apply flex items-center gap-1.5 text-xs text-fg-faint ml-auto;
}
.card-side {
  min-height: 10.5rem;
}
.card-text {
  @apply text-base;
}
.flip-enter-active,
.flip-leave-active {
  transition: transform 0.25s ease, opacity 0.25s ease;
}
.flip-enter-from {
  transform: rotateX(-90deg);
  opacity: 0;
}
.flip-leave-to {
  transform: rotateX(90deg);
  opacity: 0;
}
.hint {
  @apply mt-4;
}
.hint-toggle {
  @apply text-xs text-fg-faint cursor-pointer list-none flex items-center gap-1;
}
.hint-toggle::-webkit-details-marker {
  display: none;
}
.hint-icon {
  @apply transition-transform;
}
details[open] > .hint-toggle .hint-icon {
  transform: rotate(90deg);
}
.hint-list {
  @apply flex flex-col gap-1 mt-2 ml-3;
}
.hint-link {
  @apply flex items-center gap-1.5 text-xs text-fg-faint no-underline
         hover:text-accent-blue transition-colors;
}
.actions {
  @apply flex items-center gap-2 mb-3;
}
.btn {
  @apply text-xs px-3 py-1.5 rounded-sm border cursor-pointer transition-colors;
}
.btn-wrong {
  @apply text-accent-red border-accent-red/30 hover:border-accent-red;
}
.btn-right {
  @apply text-accent-green border-accent-green/30 hover:border-accent-green;
}
.btn-right-done {
  @apply bg-accent-green/15 text-accent-green/70 border-accent-green/30 cursor-default;
}
</style>
