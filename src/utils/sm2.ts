import type {
  ReviewState,
} from '@/types/flashcard';
import {
  todayISO, addDaysISO,
} from '@/utils/date';

export const MASTERED_INTERVAL_DAYS = 21;

export function sm2 (state: ReviewState, quality: number): ReviewState {
  let {
    easeFactor, interval, repetitions,
  } = state;

  if (3 <= quality) {
    if (repetitions === 0) interval = 1;
    else if (repetitions === 1) interval = 6;
    else interval = Math.round(interval * easeFactor);
    repetitions += 1;
  } else {
    repetitions = 0;
    interval = 1;
  }

  easeFactor = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
  if (easeFactor < 1.3) easeFactor = 1.3;

  return {
    easeFactor,
    interval,
    repetitions,
    nextReviewDate: addDaysISO(interval),
    lastReviewedAt: todayISO(),
  };
}

export function isDue (state: ReviewState, today?: string): boolean {
  return state.nextReviewDate <= (today ?? todayISO());
}

export function isAnsweredToday (state: ReviewState, today?: string): boolean {
  return state.lastReviewedAt === (today ?? todayISO()) && !isDue(state, today);
}

export function isStale (state: ReviewState, today?: string): boolean {
  if (!state.lastReviewedAt) return true;
  const t = today ?? todayISO();
  return state.lastReviewedAt < addDaysISO(-7) && isDue(state, t);
}

export function qualityFromCorrect (correct: boolean): number {
  return correct ? 4 : 1;
}

export function defaultReviewState (): ReviewState {
  return {
    easeFactor: 2.5,
    interval: 0,
    repetitions: 0,
    nextReviewDate: todayISO(),
    lastReviewedAt: 'Not reviewed yet',
  };
}
