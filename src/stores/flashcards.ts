import {
  defineStore,
} from 'pinia';
import {
  ref, computed,
} from 'vue';
import {
  useDebounceFn,
} from '@vueuse/core';
import {
  allFlashcards,
} from 'content-collections';
import type {
  Flashcard, ReviewState,
} from '@/types/flashcard';
import {
  todayISO,
} from '@/utils/date';
import {
  sm2, isDue, qualityFromCorrect, defaultReviewState, MASTERED_INTERVAL_DAYS,
} from '@/utils/sm2';
import {
  useAuth, useReviewSync,
} from '@/composables/useSupabase';

const STORAGE_KEY = 'scrambled_review_state';

const allCards: Flashcard[] = allFlashcards.map((card) => ({
  slug: card._meta.fileName.replace('.md', ''),
  createdAt: card.createdAt,
  updatedAt: card.updatedAt,
  question: card.question,
  answer: card.answer,
  deck: card.deck,
  tags: card.tags ?? [],
  concepts: card.concepts,
  books: card.books,
}));

function loadReviewState (): Record<string, ReviewState> {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw == null) return {};
    return JSON.parse(raw);
  } catch {
    return {};
  }
}

function saveReviewState (state: Record<string, ReviewState>) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
}

function mergeStates (
  local: Record<string, ReviewState>,
  remote: Record<string, ReviewState>,
): Record<string, ReviewState> {
  const merged = {
    ...local,
  };
  for (const [
    slug,
    remoteState,
  ] of Object.entries(remote)) {
    const localState = local[slug];
    if (!localState) {
      merged[slug] = remoteState;
    } else if (remoteState.lastReviewedAt && localState.lastReviewedAt
      && localState.lastReviewedAt < remoteState.lastReviewedAt) {
      merged[slug] = remoteState;
    }
  }
  return merged;
}

export const useFlashcardStore = defineStore('flashcards', () => {
  const cards = allCards;
  const reviewState = ref<Record<string, ReviewState>>(
    typeof window !== 'undefined' ? loadReviewState() : {},
  );

  const {
    isLoggedIn,
  } = useAuth();
  const {
    pushState, pullState,
  } = useReviewSync();

  const debouncedPush = useDebounceFn(() => {
    if (isLoggedIn.value) pushState(reviewState.value);
  }, 3000);

  function getState (slug: string): ReviewState {
    return reviewState.value[slug] ?? defaultReviewState();
  }

  function getByDeck (deck: string) {
    return cards.filter((card) => card.deck === deck);
  }

  function getByConcept (conceptSlug: string) {
    return cards.filter((card) => card.concepts.includes(conceptSlug));
  }

  function getByJourney (conceptSlugs: string[]) {
    const set = new Set(conceptSlugs);
    return cards.filter((card) => card.concepts.some((slug) => set.has(slug)));
  }

  function getDueCards (pool?: Flashcard[]) {
    const today = todayISO();
    return (pool ?? cards).filter((card) => isDue(getState(card.slug), today));
  }

  function reviewCard (slug: string, correct: boolean) {
    const quality = qualityFromCorrect(correct);
    reviewState.value[slug] = sm2(getState(slug), quality);
    saveReviewState(reviewState.value);
    debouncedPush();
  }

  async function syncWithRemote () {
    if (!isLoggedIn.value) return;
    const remote = await pullState() as Record<string, ReviewState> | undefined;
    if (remote) {
      reviewState.value = mergeStates(reviewState.value, remote);
      saveReviewState(reviewState.value);
    }
    await pushState(reviewState.value);
  }

  const decks = computed(() => [...new Set(cards.map((card) => card.deck))].sort());

  function statsForCards (pool: Flashcard[]) {
    const today = todayISO();
    let dueToday = 0;
    let mastered = 0;
    for (const card of pool) {
      const cardState = getState(card.slug);
      if (isDue(cardState, today)) dueToday++;
      if (MASTERED_INTERVAL_DAYS <= cardState.interval) mastered++;
    }
    return {
      total: pool.length,
      dueToday,
      mastered,
    };
  }

  const stats = computed(() => statsForCards(cards));

  return {
    cards,
    decks,
    reviewState,
    stats,
    getState,
    getByDeck,
    getByConcept,
    getByJourney,
    getDueCards,
    reviewCard,
    syncWithRemote,
    statsForCards,
  };
});
