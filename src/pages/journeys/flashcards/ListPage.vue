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
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Flashcards', to: `/journeys/${slug}/flashcards` }]" />
    </div>

    <div class="flex flex-wrap items-center justify-between gap-1 mb-6">
      <h1 class="text-xl font-bold">
        Flashcards
      </h1>
    </div>

    <div v-if="mode === 'decks'">
      <div class="flex flex-wrap items-center justify-between gap-2 mb-3">
        <h2 class="text-sm font-medium">
          Select a deck
        </h2>
        <GButton
          v-if="journeyCards.length"
          :prominence="GButtonProminence.Secondary"
          :semantic="GButtonSemantic.Success"
          :size="GButtonSize.Sm"
          @click="startQuiz()"
        >
          &#9654; Quiz mode
        </GButton>
      </div>
      <GFilterable
        :columns="1"
        :page-size="20"
        class="mb-4"
      >
        <GFilterableItem
          value="__all__"
          label="All"
        >
          <button
            class="deck-btn w-full border rounded-sm px-4 py-3 text-left text-sm transition-colors flex flex-wrap items-center justify-between gap-1 cursor-pointer"
            @click="openDeck()"
          >
            <span class="font-medium">All</span>
            <span class="deck-meta text-xs">{{ journeyStats.total }} cards · {{ journeyStats.dueToday }} due</span>
          </button>
        </GFilterableItem>
        <GFilterableItem
          v-for="d in journeyDecks"
          :key="d"
          :value="d"
          :label="formatSlug(d)"
        >
          <button
            class="deck-btn w-full border rounded-sm px-4 py-3 text-left text-sm transition-colors flex flex-wrap items-center justify-between gap-1 cursor-pointer"
            @click="openDeck(d)"
          >
            <span class="font-medium">{{ formatSlug(d) }}</span>
            <span class="deck-meta text-xs">{{ deckStats.get(d)?.count ?? 0 }} cards · {{ deckStats.get(d)?.due ?? 0 }} due</span>
          </button>
        </GFilterableItem>
      </GFilterable>
      <p
        v-if="!journeyCards.length"
        class="fc-empty text-center text-sm py-8"
      >
        No flashcards for this journey yet.
      </p>
    </div>

    <div v-if="mode === 'table'">
      <div class="flex items-center justify-between mb-4">
        <span class="text-sm font-medium">{{ activeDeck ? formatSlug(activeDeck) : 'All cards' }} ({{ activePool.length }})</span>
        <GButton
          :prominence="GButtonProminence.Secondary"
          :semantic="GButtonSemantic.Success"
          :size="GButtonSize.Sm"
          @click="startQuiz()"
        >
          ▶ Quiz mode
        </GButton>
      </div>

      <div class="overflow-x-auto w-full">
        <GTable
          v-if="activePool.length"
          v-model:sort-key="tableSortKey"
          v-model:sort-asc="tableSortAsc"
        >
          <GTableHeader>
            <GTableRow>
              <GTableCell
                header
                class="px-3"
                style="min-width: 14rem"
              >
                Question <GTableSorter
                  col-key="question"
                  :on-sort="toggleSort"
                />
              </GTableCell>
              <GTableCell
                header
                class="px-3"
                style="min-width: 4rem"
              >
                Mastery <GTableSorter
                  col-key="mastery"
                  :on-sort="toggleSort"
                />
              </GTableCell>
              <GTableCell
                header
                class="px-3"
                style="min-width: 3rem"
              >
                Stale <GTableSorter
                  col-key="stale"
                  :on-sort="toggleSort"
                />
              </GTableCell>
              <GTableCell
                header
                class="px-3"
                style="min-width: 6rem"
              >
                Last reviewed <GTableSorter
                  col-key="lastReviewed"
                  :on-sort="toggleSort"
                />
              </GTableCell>
              <GTableCell
                header
                class="px-3"
              />
            </GTableRow>
          </GTableHeader>
          <GTableBody>
            <GTableRow
              v-for="card in activePool"
              :key="card.slug"
              class="fc-table-row cursor-pointer transition-colors"
              @click="$router.push(`/journeys/${slug}/flashcards/${card.slug}`)"
            >
              <GTableCell class="max-w-md truncate px-3">
                <router-link
                  :to="`/journeys/${slug}/flashcards/${card.slug}`"
                  class="fc-question-link no-underline hover:underline truncate block"
                >
                  {{ card.question }}
                </router-link>
              </GTableCell>
              <GTableCell class="px-3">
                <span
                  v-tooltip="masteryLabel(card.slug)"
                  class="status-ring"
                  :style="{ '--progress': masteryProgress(card.slug), '--ring-color': ringColor(masteryProgress(card.slug)) }"
                />
              </GTableCell>
              <GTableCell>
                <span
                  v-if="cardIsStale(card.slug)"
                  class="fc-stale text-xs"
                >stale</span>
              </GTableCell>
              <GTableCell class="fc-last-reviewed text-xs whitespace-nowrap px-3">
                {{ lastReviewed(card.slug) }}
              </GTableCell>
              <GTableCell class="flex gap-1 px-3">
                <GButton
                  :prominence="GButtonProminence.Ghost"
                  :semantic="GButtonSemantic.Destructive"
                  :size="GButtonSize.Xs"
                  @click.stop="flashcardStore.reviewCard(card.slug, false)"
                >
                  <GIcon
                    :name="GIconName.X"
                    :size="12"
                    weight="bold"
                  />
                </GButton>
                <GButton
                  :prominence="GButtonProminence.Ghost"
                  :semantic="GButtonSemantic.Success"
                  :size="GButtonSize.Xs"
                  :disabled="answeredToday(card.slug)"
                  @click.stop="flashcardStore.reviewCard(card.slug, true)"
                >
                  <GIcon
                    :name="GIconName.Check"
                    :size="12"
                    weight="bold"
                  />
                </GButton>
              </GTableCell>
            </GTableRow>
          </GTableBody>
        </GTable>
      </div>
    </div>

    <div v-if="mode === 'quiz'">
      <div v-if="currentCard">
        <div class="mb-4">
          <span class="fc-quiz-counter text-xs mb-2 block">{{ currentIndex + 1 }}/{{ queue.length }}</span>
          <div class="flex items-center gap-2">
            <GButton
              v-if="!flipped"
              :prominence="GButtonProminence.Secondary"
              :size="GButtonSize.Sm"
              @click="flipped = true"
            >
              Show answer
            </GButton>
            <template v-else>
              <GButton
                :prominence="GButtonProminence.Secondary"
                :semantic="GButtonSemantic.Destructive"
                :size="GButtonSize.Sm"
                @click="answer(false)"
              >
                Wrong
              </GButton>
              <GButton
                :prominence="GButtonProminence.Secondary"
                :semantic="GButtonSemantic.Success"
                :size="GButtonSize.Sm"
                @click="answer(true)"
              >
                Right
              </GButton>
            </template>
            <GButton
              v-if="currentIndex > 0"
              :prominence="GButtonProminence.Ghost"
              :size="GButtonSize.Sm"
              class="ml-auto"
              @click="goBackCard()"
            >
              &larr; Prev
            </GButton>
          </div>
        </div>

        <div
          class="fc-card-wrap border rounded-sm p-6 cursor-pointer"
          style="perspective: 800px;"
          @click="flipped = !flipped"
        >
          <Transition
            name="flip"
            mode="out-in"
          >
            <div
              v-if="!flipped"
              key="front"
              class="flex flex-col"
              style="min-height: 10.5rem;"
            >
              <div class="fc-card-label text-xs mb-4">
                question
              </div>
              <div
                class="card-text prose text-left text-base flex-1"
                v-html="quizQuestion"
              />
            </div>
            <div
              v-else
              key="back"
              class="flex flex-col"
              style="min-height: 10.5rem;"
            >
              <div class="fc-card-label text-xs mb-4">
                answer
              </div>
              <div
                class="card-text prose text-left text-base flex-1"
                v-html="quizAnswer"
              />
            </div>
          </Transition>
        </div>
      </div>

      <div
        v-else
        class="fc-card-wrap border rounded-sm p-6 text-center"
      >
        <h2 class="text-base font-bold mb-1">
          Done.
        </h2>
        <p class="fc-quiz-score text-sm mb-3">
          {{ sessionRight }} right, {{ sessionWrong }} wrong
        </p>
        <div
          v-if="sessionRight + sessionWrong > 0"
          class="fc-progress-bg w-48 h-1.5 rounded-sm mx-auto overflow-hidden"
        >
          <div
            class="fc-progress-bar h-full rounded-sm transition-[width] duration-300"
            :style="{ width: `${(sessionRight / (sessionRight + sessionWrong)) * 100}%` }"
          />
        </div>
        <GButton
          :prominence="GButtonProminence.Secondary"
          :size="GButtonSize.Sm"
          class="mt-4"
          @click="setQuery({ mode: 'table', deck: activeDeck })"
        >
          done
        </GButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  ref, computed, watch,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute, useRouter,
} from 'vue-router';
import {
  GIcon, GIconName,
  GTable, GTableHeader, GTableBody, GTableRow, GTableCell, GTableSorter,
  GFilterable, GFilterableItem,
  GButton, GButtonProminence, GButtonSemantic, GButtonSize,
} from '@hdnax/genuix';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useFlashcardStore,
} from '@/stores/flashcards';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  renderMarkdown, loadContent,
} from '@/utils/content';
import {
  formatSlug, ringColor,
} from '@/utils/format';
import {
  useTableSort,
} from '@/composables/useTableSort';
import {
  isDue, isStale, isAnsweredToday, MASTERED_INTERVAL_DAYS,
} from '@/utils/sm2';
import type {
  Flashcard,
} from '@/types/flashcard';

const route = useRoute();
const router = useRouter();
const slug = computed(() => route.params.slug as string);
const conceptStore = useConceptStore();
const flashcardStore = useFlashcardStore();

useSeo({
  title: computed(() => `Flashcards - ${slug.value}`),
  path: computed(() => `/journeys/${slug.value}/flashcards`),
  type: 'website',
});

const mode = computed(() => (route.query.mode as string) || 'decks');
const activeDeck = computed(() => (route.query.deck as string) || undefined);

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));
const journeyConceptSlugs = computed(() => journeyConcepts.value.map((c) => c.slug));
const journeyCards = computed(() => flashcardStore.getByJourney(journeyConceptSlugs.value));
const journeyDecks = computed(() => [...new Set(journeyCards.value.map((c) => c.deck))].sort());
const journeyStats = computed(() => flashcardStore.statsForCards(journeyCards.value));

const {
  sortKey: tableSortKey, sortAsc: tableSortAsc, toggleSort,
} = useTableSort();

const activePool = computed(() => {
  const pool = activeDeck.value
    ? journeyCards.value.filter((c) => c.deck === activeDeck.value)
    : journeyCards.value;
  if (!tableSortKey.value) return pool;
  const list = [...pool];
  const dir = tableSortAsc.value ? 1 : -1;
  const sortKey = tableSortKey.value;
  const states = new Map(list.map((c) => [
    c.slug,
    flashcardStore.getState(c.slug),
  ]));
  list.sort((a, b) => {
    if (sortKey === 'question') return dir * a.question.localeCompare(b.question);
    const sa = states.get(a.slug) ?? flashcardStore.getState(a.slug);
    const sb = states.get(b.slug) ?? flashcardStore.getState(b.slug);
    if (sortKey === 'mastery') return dir * (sa.interval - sb.interval);
    if (sortKey === 'stale') return dir * (Number(isStale(sa)) - Number(isStale(sb)));
    if (sortKey === 'lastReviewed') return dir * (sa.lastReviewedAt || '').localeCompare(sb.lastReviewedAt || '');
    return 0;
  });
  return list;
});

const deckStats = computed(() => {
  const stats = new Map<string, {
    count: number;
    due: number;
  }>();
  for (const c of journeyCards.value) {
    const deckStat = stats.get(c.deck) || {
      count: 0,
      due: 0,
    };
    deckStat.count++;
    if (isDue(flashcardStore.getState(c.slug))) deckStat.due++;
    stats.set(c.deck, deckStat);
  }
  return stats;
});

function setQuery (q: Record<string, string | undefined>) {
  const query: Record<string, string> = {};
  for (const [
    key,
    v,
  ] of Object.entries(q)) {
    if (v) query[key] = v;
  }
  router.replace({
    query,
  });
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
  const cardState = flashcardStore.getState(cardSlug);
  if (MASTERED_INTERVAL_DAYS <= cardState.interval) return '100';
  if (3 <= cardState.repetitions) return '60';
  if (1 <= cardState.repetitions) return '30';
  return '0';
}

function masteryLabel (cardSlug: string): string {
  const cardState = flashcardStore.getState(cardSlug);
  if (MASTERED_INTERVAL_DAYS <= cardState.interval) return 'Mastered';
  if (3 <= cardState.repetitions) return 'Reviewing';
  if (1 <= cardState.repetitions) return 'Learning';
  return 'New';
}

function cardIsStale (cardSlug: string): boolean {
  return isStale(flashcardStore.getState(cardSlug));
}

function answeredToday (cardSlug: string): boolean {
  return isAnsweredToday(flashcardStore.getState(cardSlug));
}

function lastReviewed (cardSlug: string): string {
  const cardState = flashcardStore.getState(cardSlug);
  return cardState.lastReviewedAt || '-';
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
  const card = currentCard.value;
  if (!card) return '';
  return renderMarkdown(card.question);
}, '');

const {
  state: quizAnswer, execute: reloadAnswer,
} = useAsyncState(async () => {
  const card = currentCard.value;
  if (!card) return '';
  const body = await loadContent(card.slug);
  if (body) return body;
  return card.answer && card.answer !== 'TODO' ? await renderMarkdown(card.answer) : '<p style="color: var(--gui-neutral-solid)">No answer yet.</p>';
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

<style>
.deck-btn { border-color: var(--gui-neutral-border); }
.deck-btn:hover { border-color: var(--gui-neutral-solid); }
.deck-meta { color: var(--gui-neutral-solid); }
.fc-empty { color: var(--gui-neutral-solid); }
.fc-table-row:hover { background-color: var(--gui-neutral-bg-subtle); }
.fc-question-link { color: var(--gui-neutral-fg); }
.fc-question-link:hover { color: var(--gui-info-solid); }
.fc-stale { color: var(--gui-danger-solid); }
.fc-last-reviewed { color: var(--gui-neutral-solid); }
.fc-quiz-counter { color: var(--gui-neutral-solid); }
.fc-card-label { color: var(--gui-neutral-solid); }
.fc-card-wrap { border-color: var(--gui-neutral-border); }
.fc-quiz-score { color: var(--gui-neutral-fg-muted); }
.fc-progress-bg { background-color: color-mix(in oklch, var(--gui-danger-solid) 20%, transparent); }
.fc-progress-bar { background-color: var(--gui-success-solid); }
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
.card-text .heading-anchor {
  display: none;
}
</style>
