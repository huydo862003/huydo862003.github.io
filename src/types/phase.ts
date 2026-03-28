export interface Phase {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  journey: string;
  status: 'active' | 'on-hold' | 'completed';
  order: number;
  books: string[];
  concepts: string[];
}
