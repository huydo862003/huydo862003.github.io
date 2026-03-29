export interface Paper {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  authors: string[];
  year: string;
  venue: string;
  url: string;
  journey: string;
  tags: string[];
  concepts: string[];
  status: 'to-read' | 'reading' | 'read';
}
