export interface Book {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  author: string;
  date: string;
  journey: string;
  description: string;
  isbn: string;
  url: string;
  cover: string;
  tags: string[];
  concepts: string[];
  parent: string;
  children: string[];
}
