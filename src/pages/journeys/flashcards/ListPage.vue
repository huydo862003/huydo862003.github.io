<template>
  <div class="page">
    <div class="top-bar">
      <a
        v-if="mode !== 'decks'"
        class="back"
        href="#"
        @click.prevent="goBack"
      >
        &larr; {{ mode === 'quiz' ? 'back to cards' : 'back to decks' }}
      </a>
      <router-link
        v-else
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Flashcards', to: `/journeys/${slug}/flashcards` }]" />
    </div>

    <div class="title-row">
      <h1>Flashcards</h1>
    </div>

    <!-- DECK BROWSER -->
    <div v-if="mode === 'decks'">
      <div class="deck-header">
        <h2 class="sub">
          Select a deck
        </h2>
        <button
          v-if="journeyCards.length"
          class="btn btn-quiz"
          @click="startQuiz()"
        >
          &#9654; Quiz mode
        </button>
      </div>
      <ul class="decks">
        <li>
          <button
            class="deck"
            @click="openDeck()"
          >
            <span class="deck-name">All</span>
            <span class="deck-meta">{{ journeyStats.total }} cards · {{ journeyStats.dueToday }} due</span>
          </button>
        </li>
        <li
          v-for="d in journeyDecks"
          :key="d"
        >
          <button
            class="deck"
            @click="openDeck(d)"
          >
            <span class="deck-name">{{ formatSlug(d) }}</span>
            <span class="deck-meta">{{ deckStats.get(d)?.count ?? 0 }} cards · {{ deckStats.get(d)?.due ?? 0 }} due</span>
          </button>
        </li>
      </ul>
      <p
        v-if="!journeyCards.length"
        class="empty-msg"
      >
        No flashcards for this journey yet.
      </p>
    </div>

    <!-- CARD TABLE -->
    <div v-if="mode === 'table'">
      <div class="table-header">
        <span class="table-title">{{ activeDeck ? formatSlug(activeDeck) : 'All cards' }} ({{ activePool.length }})</span>
        <button
          class="btn btn-quiz"
          @click="startQuiz()"
        >
          ▶ Quiz mode
        </button>
      </div>

      <div class="table-scroll">
        <table
          v-if="activePool.length"
          class="card-table"
        >
          <thead>
            <tr>
              <th
                class="sortable col-question"
                @click="toggleSort('question')"
              >
                Question {{ sortIcon('question') }}
              </th>
              <th
                class="sortable col-mastery"
                @click="toggleSort('mastery')"
              >
                Mastery {{ sortIcon('mastery') }}
              </th>
              <th
                class="sortable col-stale"
                @click="toggleSort('stale')"
              >
                Stale {{ sortIcon('stale') }}
              </th>
              <th
                class="sortable col-reviewed"
                @click="toggleSort('lastReviewed')"
              >
                Last reviewed {{ sortIcon('lastReviewed') }}
              </th>
              <th />
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="card in activePool"
              :key="card.slug"
              class="row"
              @click="$router.push(`/journeys/${slug}/flashcards/${card.slug}`)"
            >
              <td class="q-cell">
                <router-link
                  :to="`/journeys/${slug}/flashcards/${card.slug}`"
                  class="card-link"
                >
                  {{ card.question }}
                </router-link>
              </td>
              <td>
                <span
                  v-tooltip="masteryLabel(card.slug)"
                  class="status-ring"
                  :style="{ '--progress': masteryProgress(card.slug), '--ring-color': ringColor(masteryProgress(card.slug)) }"
                />
              </td>
              <td>
                <span
                  v-if="cardIsStale(card.slug)"
                  class="stale"
                >stale</span>
              </td>
              <td class="date-cell">
                {{ lastReviewed(card.slug) }}
              </td>
              <td class="action-cell">
                <button
                  class="inline-btn inline-wrong"
                  @click.stop="flashcardStore.reviewCard(card.slug, false)"
                >
                  <PhX
                    :size="12"
                    weight="bold"
                  />
                </button>
                <button
                  class="inline-btn inline-right"
                  :disabled="answeredToday(card.slug)"
                  @click.stop="flashcardStore.reviewCard(card.slug, true)"
                >
                  <PhCheck
                    :size="12"
                    weight="bold"
                  />
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- QUIZ MODE -->
    <div v-if="mode === 'quiz'">
      <div
        v-if="currentCard"
      >
        <div class="quiz-header">
          <span class="progress">{{ currentIndex + 1 }}/{{ queue.length }}</span>
          <div class="card-actions">
            <button
              v-if="!flipped"
              class="btn"
              @click="flipped = true"
            >
              Show answer
            </button>
            <template v-else>
              <button
                class="btn btn-wrong"
                @click="answer(false)"
              >
                Wrong
              </button>
              <button
                class="btn btn-right"
                @click="answer(true)"
              >
                Right
              </button>
            </template>
            <button
              v-if="currentIndex > 0"
              class="btn btn-prev"
              @click="goBackCard()"
            >
              &larr; Prev
            </button>
          </div>
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
              <div
                class="card-text prose"
                v-html="quizQuestion"
              />
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
                class="card-text prose"
                v-html="quizAnswer"
              />
            </div>
          </Transition>
        </div>
      </div>

      <div
        v-else
        class="card-review text-center"
      >
        <h2 class="text-base font-bold mb-1">
          Done.
        </h2>
        <p class="text-sm text-fg-muted mb-3">
          {{ sessionRight }} right, {{ sessionWrong }} wrong
        </p>
        <div
          v-if="sessionRight + sessionWrong > 0"
          class="bar-wrap"
        >
          <div
            class="bar"
            :style="{ width: `${(sessionRight / (sessionRight + sessionWrong)) * 100}%` }"
          />
        </div>
        <button
          class="btn mt-4"
          @click="setQuery({ mode: 'table', deck: activeDeck })"
        >
          done
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch,
} from 'vue';
import { useAsyncState } from '@vueuse/core';
import {
  useRoute, useRouter,
} from 'vue-router';
import {
  PhX, PhCheck,
} from '@phosphor-icons/vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useConceptStore } from '@/stores/concepts';
import { useFlashcardStore } from '@/stores/flashcards';
import {
  renderMarkdown, loadContent,
} from '@/utils/content';
import {
  formatSlug, ringColor,
} from '@/utils/format';
import { useTableSort } from '@/composables/useTableSort';
import {
  isDue, isStale, isAnsweredToday, MASTERED_INTERVAL_DAYS,
} from '@/utils/sm2';
import type { Flashcard } from '@/types/flashcard';

const route = useRoute();
const router = useRouter();
const slug = computed(() => route.params.slug as string);
const conceptStore = useConceptStore();
const flashcardStore = useFlashcardStore();

const mode = computed(() => (route.query.mode as string) || 'decks');
const activeDeck = computed(() => (route.query.deck as string) || undefined);

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));
const journeyConceptSlugs = computed(() => journeyConcepts.value.map((c) => c.slug));
const journeyCards = computed(() => flashcardStore.getByJourney(journeyConceptSlugs.value));
const journeyDecks = computed(() => [...new Set(journeyCards.value.map((c) => c.deck))].sort());
const journeyStats = computed(() => flashcardStore.statsForCards(journeyCards.value));

const {
  sortKey: tableSortKey, sortAsc: tableSortAsc, toggleSort, sortIcon,
} = useTableSort();

const activePool = computed(() => {
  const pool = activeDeck.value
    ? journeyCards.value.filter((c) => c.deck === activeDeck.value)
    : journeyCards.value;
  if (!tableSortKey.value) return pool;
  const list = [...pool];
  const dir = tableSortAsc.value ? 1 : -1;
  const k = tableSortKey.value;
  const states = new Map(list.map((c) => [c.slug, flashcardStore.getState(c.slug)]));
  list.sort((a, b) => {
    if (k === 'question') return dir * a.question.localeCompare(b.question);
    const sa = states.get(a.slug) ?? flashcardStore.getState(a.slug);
    const sb = states.get(b.slug) ?? flashcardStore.getState(b.slug);
    if (k === 'mastery') return dir * (sa.interval - sb.interval);
    if (k === 'stale') return dir * (Number(isStale(sa)) - Number(isStale(sb)));
    if (k === 'lastReviewed') return dir * (sa.lastReviewedAt || '').localeCompare(sb.lastReviewedAt || '');
    return 0;
  });
  return list;
});

const deckStats = computed(() => {
  const stats = new Map<string, { count: number;
    due: number; }>();
  for (const c of journeyCards.value) {
    const s = stats.get(c.deck) || {
      count: 0,
      due: 0,
    };
    s.count++;
    if (isDue(flashcardStore.getState(c.slug))) s.due++;
    stats.set(c.deck, s);
  }
  return stats;
});

function setQuery (q: Record<string, string | undefined>) {
  const query: Record<string, string> = {};
  for (const [k, v] of Object.entries(q)) {
    if (v) query[k] = v;
  }
  router.replace({ query });
}

function openDeck (deck?: string) {
  setQuery({
    mode: 'table',
    deck,
  });
}

function goBack () {
  if (mode.value === 'quiz') {
    setQuery({
      mode: 'table',
      deck: activeDeck.value,
    });
  } else {
    setQuery({});
  }
}

function masteryProgress (cardSlug: string): string {
  const s = flashcardStore.getState(cardSlug);
  if (MASTERED_INTERVAL_DAYS <= s.interval) return '100';
  if (3 <= s.repetitions) return '60';
  if (1 <= s.repetitions) return '30';
  return '0';
}

function masteryLabel (cardSlug: string): string {
  const s = flashcardStore.getState(cardSlug);
  if (MASTERED_INTERVAL_DAYS <= s.interval) return 'Mastered';
  if (3 <= s.repetitions) return 'Reviewing';
  if (1 <= s.repetitions) return 'Learning';
  return 'New';
}

function cardIsStale (cardSlug: string): boolean {
  return isStale(flashcardStore.getState(cardSlug));
}

function answeredToday (cardSlug: string): boolean {
  return isAnsweredToday(flashcardStore.getState(cardSlug));
}

function lastReviewed (cardSlug: string): string {
  const s = flashcardStore.getState(cardSlug);
  return s.lastReviewedAt || '-';
}

const queue = ref<Flashcard[]>([]);
const currentIndex = ref(0);
const flipped = ref(false);
const sessionRight = ref(0);
const sessionWrong = ref(0);

const currentCard = computed(() => queue.value[currentIndex.value]);

const {
  state: quizQuestion, execute: reloadQuestion,
} = useAsyncState(async () => {
  const c = currentCard.value;
  if (!c) return '';
  return renderMarkdown(c.question);
}, '');

const {
  state: quizAnswer, execute: reloadAnswer,
} = useAsyncState(async () => {
  const c = currentCard.value;
  if (!c) return '';
  const body = await loadContent(c.slug);
  if (body) return body;
  return c.answer && c.answer !== 'TODO' ? await renderMarkdown(c.answer) : '<p class="text-fg-faint">No answer yet.</p>';
}, '');

watch(currentCard, () => {
  reloadQuestion();
  reloadAnswer();
});

function startQuiz () {
  const due = flashcardStore.getDueCards(activePool.value);
  const pool = due.length ? due : activePool.value;
  if (!pool.length) return;
  queue.value = [...pool];
  currentIndex.value = 0;
  flipped.value = false;
  sessionRight.value = 0;
  sessionWrong.value = 0;
  setQuery({
    mode: 'quiz',
    deck: activeDeck.value,
  });
}

function goBackCard () {
  if (0 < currentIndex.value) {
    currentIndex.value--;
    flipped.value = false;
  }
}

function answer (correct: boolean) {
  const card = currentCard.value;
  if (!card) return;
  flashcardStore.reviewCard(card.slug, correct);
  if (correct) sessionRight.value++;
  else sessionWrong.value++;
  currentIndex.value++;
  flipped.value = false;
}
</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold;
}
.title-row {
  @apply flex flex-wrap items-center justify-between gap-1 mb-6;
}
.deck-header {
  @apply flex flex-wrap items-center justify-between gap-2 mb-3;
}
.sub {
  @apply text-sm font-medium;
}
.decks {
  @apply list-none p-0 m-0 flex flex-col gap-1 mb-4;
}
.deck {
  @apply w-full border border-border rounded-sm px-4 py-3 text-left text-sm
         hover:border-fg-faint transition-colors flex flex-wrap items-center justify-between gap-1 cursor-pointer;
}
.deck-name {
  @apply font-medium;
}
.deck-meta {
  @apply text-xs text-fg-faint;
}
.empty-msg {
  @apply text-center text-sm text-fg-faint py-8;
}
.table-header {
  @apply flex items-center justify-between mb-4;
}
.table-title {
  @apply text-sm font-medium;
}
.btn-quiz {
  @apply text-sm px-3 py-1.5 rounded-sm border border-accent-green/30 text-accent-green
         hover:border-accent-green cursor-pointer transition-colors;
}
.table-scroll {
  @apply overflow-x-auto -mx-1 px-1;
}
.card-table {
  @apply w-full text-xs border-collapse;
  min-width: 36rem;
}
.col-question { min-width: 14rem; }
.col-mastery { min-width: 4rem; }
.col-stale { min-width: 3rem; }
.col-reviewed { min-width: 6rem; }
.card-table th {
  @apply text-left text-xs text-fg-faint font-medium pb-2 pr-3;
}
.card-table td {
  @apply py-2 pr-3 border-t border-border;
}
.q-cell {
  @apply max-w-md truncate;
}
.row {
  @apply cursor-pointer hover:bg-bg-subtle transition-colors;
}
.card-link {
  @apply text-fg no-underline hover:text-accent-blue hover:underline;
}
.date-cell {
  @apply text-xs text-fg-faint whitespace-nowrap;
}
.stale {
  @apply text-xs text-accent-red;
}
.action-cell {
  @apply flex gap-1;
}
.inline-btn {
  @apply w-5 h-5 flex items-center justify-center rounded-sm border border-border
         text-xs cursor-pointer transition-colors;
}
.inline-wrong {
  @apply text-accent-red hover:border-accent-red;
}
.inline-right {
  @apply text-accent-green hover:border-accent-green;
}
.quiz-header {
  @apply mb-4;
}
.progress {
  @apply text-xs text-fg-faint mb-2 block;
}
.card-actions {
  @apply flex items-center gap-2;
}
.btn-prev {
  @apply ml-auto;
}
.card-review {
  @apply border border-border rounded-sm p-6 cursor-pointer;
  perspective: 800px;
}
.card-side {
  @apply flex flex-col;
  min-height: 10.5rem;
}
.card-label {
  @apply text-xs text-fg-faint mb-4;
}
.card-text {
  @apply text-left text-base flex-1;
}
.btn {
  @apply text-xs px-2.5 py-1 rounded-sm border border-border text-fg-muted hover:border-fg-faint cursor-pointer transition-colors;
}
.btn-wrong {
  @apply text-accent-red border-accent-red/30 hover:border-accent-red;
}
.btn-right {
  @apply text-accent-green border-accent-green/30 hover:border-accent-green;
}
.bar-wrap {
  @apply w-48 h-1.5 bg-accent-red/20 rounded-sm mx-auto overflow-hidden;
}
.bar {
  @apply h-full bg-accent-green rounded-sm transition-[width] duration-300;
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
</style>

<style>
.card-text .heading-anchor {
  display: none;
}
</style>
