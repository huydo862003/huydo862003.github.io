export interface Journey {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  description: string;
  status: 'active' | 'paused' | 'completed';
  tags: string[];
}
