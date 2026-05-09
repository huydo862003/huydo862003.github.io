<template>
  <div class="page">
    <div class="top-bar">
      <RouterLink
        :to="`/journeys/${slug}/flashcards?mode=table&deck=${card?.deck ?? ''}`"
        class="back"
      >
        &larr; back to {{ card ? `${formatSlug(card.deck) } deck` : 'flashcards' }}
      </RouterLink>
      <JourneyBreadcrumb
        :crumbs="[
          {
            label: 'Journeys',
            to: '/journeys',
          },
          {
            label: slug,
            to: `/journeys/${slug}`,
          },
          {
            label: 'Flashcards',
            to: `/journeys/${slug}/flashcards`,
          },
        ]"
      />
    </div>

    <template v-if="card">
      <h1 class="text-xl font-bold mb-1">
        {{ card.question }}
      </h1>
      <p class="fc-deck text-xs mb-5">
        {{ formatSlug(card.deck) }}
      </p>

      <div class="flex items-center gap-2 mb-3">
        <GButton
          :prominence="GButtonProminence.Secondary"
          :semantic="GButtonSemantic.Destructive"
          :size="GButtonSize.Sm"
          @click="reviewWrong"
        >
          Wrong
        </GButton>
        <GButton
          :prominence="reviewedToday ? GButtonProminence.Ghost : GButtonProminence.Secondary"
          :semantic="GButtonSemantic.Success"
          :size="GButtonSize.Sm"
          :disabled="reviewedToday"
          @click="reviewRight"
        >
          {{ reviewedToday ? 'Reviewed' : 'Right' }}
        </GButton>
        <span class="fc-mastery flex items-center gap-1.5 text-xs ml-auto">
          <span
            class="status-ring"
            :style="{
              '--progress': masteryProgress,
              '--ring-color': ringColor(masteryProgress),
            }"
          />
          {{ masteryLabel }} &middot; {{ state.interval }}d
        </span>
      </div>

      <GFlippable
        :flipped="flipped"
        class="fc-flippable border rounded-sm mb-4"
        :trigger="GFlipTrigger.Click"
      >
        <template #front>
          <div class="p-4 sm:p-6 flex flex-col fc-card-face">
            <div class="fc-face-label text-xs mb-4">
              question
            </div>
            <div class="text-base">
              {{ card.question }}
            </div>
            <GCollapsible
              v-if="card.concepts.length || resolvedBooks.length"
              class="mt-4"
              @click.stop
            >
              <template #summary>
                Hint
              </template>
              <template #collapsible-content>
                <div class="flex flex-col gap-1 mt-2 ml-3">
                  <RouterLink
                    v-for="c in card.concepts"
                    :key="c"
                    :to="`/journeys/${slug}/concepts/${c}`"
                    class="fc-hint-link flex items-center gap-1.5 text-xs no-underline transition-colors"
                  >
                    <GIcon
                      :name="GIconName.Brain"
                      :size="12"
                    />
                    {{ conceptStore.getBySlug(c)?.title ?? formatSlug(c) }}
                  </RouterLink>
                  <RouterLink
                    v-for="b in resolvedBooks"
                    :key="b.slug"
                    :to="`/journeys/${slug}/books/${b.slug}`"
                    class="fc-hint-link flex items-center gap-1.5 text-xs no-underline transition-colors"
                  >
                    <GIcon
                      :name="GIconName.Book"
                      :size="12"
                    />
                    {{ b.title }}
                  </RouterLink>
                </div>
              </template>
            </GCollapsible>
          </div>
        </template>
        <template #back>
          <div class="p-4 sm:p-6 flex flex-col fc-card-face">
            <div class="fc-face-label text-xs mb-4">
              answer
            </div>
            <div
              v-if="answer"
              class="text-base prose"
              v-html="answer"
            />
            <p
              v-else
              class="fc-no-answer text-base"
            >
              No answer yet.
            </p>
          </div>
        </template>
      </GFlippable>

      <ResourcePagination
        kind="flashcard"
        :prev="previousCard"
        :next="nextCard"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <RouterLink :to="`/journeys/${slug}/flashcards`">
          Back to flashcards
        </RouterLink>
      </p>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch, defineAsyncComponent,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  GIcon, GIconName, GFlippable, GFlipTrigger, GCollapsible,
  GButton, GButtonProminence, GButtonSemantic, GButtonSize,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useFlashcardStore,
} from '@/stores/flashcards';
import {
  renderMarkdown, loadContent,
} from '@/utils/content';
import {
  formatSlug, ringColor,
} from '@/utils/format';
import {
  MASTERED_INTERVAL_DAYS,
} from '@/utils/sm2';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useBookStore,
} from '@/stores/books';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const cardSlug = computed(() => route.params.cardSlug as string);
const flashcardStore = useFlashcardStore();
const conceptStore = useConceptStore();
const bookStore = useBookStore();

const card = computed(() => flashcardStore.cards.find((flashcard) => flashcard.slug === cardSlug.value));

useSeo({
  title: computed(() => card.value?.question),
  description: computed(() => {
    const currentCard = card.value;

    if (!currentCard) return undefined;
    const answerPreview = currentCard.answer && currentCard.answer !== 'TODO' ? ` Answer: ${currentCard.answer.slice(0, 120)}${120 < currentCard.answer.length ? '...' : ''}` : '';

    return `Flashcard from the ${currentCard.deck} deck.${answerPreview}`;
  }),
  tags: computed(() => {
    const currentCard = card.value;

    if (!currentCard) return undefined;

    return [
      ...(currentCard.tags ?? []),
      currentCard.deck,
      slug.value,
      'flashcard',
      'spaced repetition',
    ];
  }),
  path: computed(() => `/journeys/${slug.value}/flashcards/${cardSlug.value}`),
  publishedTime: computed(() => card.value?.createdAt || undefined),
  modifiedTime: computed(() => card.value?.updatedAt || undefined),
});
const flipped = ref(false);

watch(cardSlug, () => {
  flipped.value = false;
});

const journeyCards = computed(() => {
  const slugs = conceptStore.getByJourney(slug.value).map((concept) => concept.slug);

  return flashcardStore.getByJourney(slugs);
});
const currentIndex = computed(() => journeyCards.value.findIndex((flashcard) => flashcard.slug === cardSlug.value));
const previousCard = computed(() => {
  const previous = journeyCards.value[currentIndex.value - 1];

  return previous && {
    to: `/journeys/${slug.value}/flashcards/${previous.slug}`,
    title: previous.question,
  };
});
const nextCard = computed(() => {
  const next = journeyCards.value[currentIndex.value + 1];

  return next && {
    to: `/journeys/${slug.value}/flashcards/${next.slug}`,
    title: next.question,
  };
});
const state = computed(() => flashcardStore.getState(cardSlug.value));
const reviewedToday = computed(() => {
  const lastReviewDate = state.value.lastReviewedAt;

  return lastReviewDate === new Date()
    .toISOString()
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
  const cardState = state.value;

  if (MASTERED_INTERVAL_DAYS <= cardState.interval) return '100';
  if (3 <= cardState.repetitions) return '60';
  if (1 <= cardState.repetitions) return '30';

  return '0';
});

const masteryLabel = computed(() => {
  const cardState = state.value;

  if (MASTERED_INTERVAL_DAYS <= cardState.interval) return 'Mastered';
  if (3 <= cardState.repetitions) return 'Reviewing';
  if (1 <= cardState.repetitions) return 'Learning';

  return 'New';
});

const resolvedBooks = computed(() =>
  (card.value?.books ?? [])
    .map((bookSlug) => bookStore.getBySlug(bookSlug))
    .filter((book): book is NonNullable<typeof book> => !!book));

function reviewRight () {
  flashcardStore.reviewCard(card.value!.slug, true);
}

function reviewWrong () {
  flashcardStore.reviewCard(card.value!.slug, false);
}
</script>

<style scoped>
.fc-deck { color: var(--gui-neutral-solid); }
.fc-mastery { color: var(--gui-neutral-solid); }
.fc-flippable { border-color: var(--gui-neutral-border); }
.fc-card-face { min-height: 10.5rem; }
.fc-face-label { color: var(--gui-neutral-solid); }
.fc-hint-link { color: var(--gui-neutral-solid); }
.fc-hint-link:hover { color: var(--gui-info-solid); }
.fc-no-answer { color: var(--gui-neutral-solid); }
</style>
