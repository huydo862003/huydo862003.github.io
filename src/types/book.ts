export interface Book {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  author: string;
  date: string;
  journey: string;
  tags: string[];
  concepts: string[];
  parent: string;
  children: string[];
}
