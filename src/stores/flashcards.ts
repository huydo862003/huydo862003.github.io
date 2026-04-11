import { defineStore } from 'pinia';
import {
  ref, computed,
} from 'vue';
import { useDebounceFn } from '@vueuse/core';
import { allFlashcards } from 'content-collections';
import type {
  Flashcard, ReviewState,
} from '@/types/flashcard';
import { todayISO } from '@/utils/date';
import {
  sm2, isDue, qualityFromCorrect, defaultReviewState, MASTERED_INTERVAL_DAYS,
} from '@/utils/sm2';
import {
  useAuth, useReviewSync,
} from '@/composables/useSupabase';

const STORAGE_KEY = 'scrambled_review_state';

const allCards: Flashcard[] = allFlashcards.map((c) => ({
  slug: c._meta.fileName.replace('.md', ''),
  createdAt: c.createdAt,
  updatedAt: c.updatedAt,
  question: c.question,
  answer: c.answer,
  deck: c.deck,
  tags: c.tags ?? [],
  concepts: c.concepts,
  books: c.books,
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
  const merged = { ...local };
  for (const [slug, remoteState] of Object.entries(remote)) {
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

  const { isLoggedIn } = useAuth();
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
    return cards.filter((c) => c.deck === deck);
  }

  function getByConcept (s: string) {
    return cards.filter((c) => c.concepts.includes(s));
  }

  function getByJourney (conceptSlugs: string[]) {
    const set = new Set(conceptSlugs);
    return cards.filter((c) => c.concepts.some((s) => set.has(s)));
  }

  function getDueCards (pool?: Flashcard[]) {
    const today = todayISO();
    return (pool ?? cards).filter((c) => isDue(getState(c.slug), today));
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

  const decks = computed(() => [...new Set(cards.map((c) => c.deck))].sort());

  function statsForCards (pool: Flashcard[]) {
    const today = todayISO();
    let dueToday = 0;
    let mastered = 0;
    for (const c of pool) {
      const s = getState(c.slug);
      if (isDue(s, today)) dueToday++;
      if (MASTERED_INTERVAL_DAYS <= s.interval) mastered++;
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
