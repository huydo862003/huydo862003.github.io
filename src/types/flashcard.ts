export interface Flashcard {
  slug: string;
  createdAt: string;
  updatedAt: string;
  question: string;
  answer: string;
  deck: string;
  concepts: string[];
  books: string[];
}

export interface ReviewState {
  easeFactor: number;
  interval: number;
  repetitions: number;
  nextReviewDate: string;
  lastReviewedAt?: string;
}
