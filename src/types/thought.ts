export interface Thought {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  date: string;
  description: string;
  tags: string[];
  archived?: boolean;
  concepts: string[];
  journeys: string[];
}
