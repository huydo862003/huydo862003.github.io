export interface BlogPost {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  url: string;
  author: string;
  journey: string;
  site: string;
  tags: string[];
}

export interface BlogSite {
  slug: string;
  createdAt: string;
  updatedAt: string;
  title: string;
  url: string;
  author: string;
  journey: string;
  latestPost: string;
  lastChecked: string;
  posts: string[];
}
