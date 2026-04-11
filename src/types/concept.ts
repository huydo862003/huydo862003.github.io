export interface Concept {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  journey: string;
  description: string;
  status: 'learning' | 'reviewing' | 'mastered';
  tags: string[];
  books: string[];
  dependsOn: string[];
  blocks: string[];
}
