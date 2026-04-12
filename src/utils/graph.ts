import {
  allGraphs,
} from 'content-collections';

export interface GraphNode {
  id: string;
  title: string;
  type: string;
  journey: string;
  links: number;
}

export interface GraphEdge {
  source: string;
  target: string;
}

export const TYPE_COLORS: Record<string, string> = {
  concepts: '#6ae',
  books: '#ca3',
  flashcards: '#3d9a4d',
  phases: '#e66',
  journeys: '#d2a8ff',
  blogs: '#ffa657',
  thoughts: '#999',
};

const slugSet = new Set(allGraphs.map((n) => n.slug));

export const nodes: GraphNode[] = allGraphs.map((n) => ({
  id: n.slug,
  title: n.title,
  type: n.type,
  journey: n.journey,
  links: 0,
}));

const nodeMap = new Map(nodes.map((n) => [
  n.id,
  n,
]));

export const edges: GraphEdge[] = [
];
for (const n of allGraphs) {
  for (const target of n.forwardLinks) {
    if (slugSet.has(target) && target !== n.slug) {
      edges.push({
        source: n.slug,
        target,
      });
      const src = nodeMap.get(n.slug);
      const tgt = nodeMap.get(target);
      if (src) src.links++;
      if (tgt) tgt.links++;
    }
  }
}

export function nodeRoute (node: GraphNode): string {
  if (node.type === 'journeys') return `/journeys/${node.id}`;
  if (node.type === 'thoughts') return `/thoughts/${node.id}`;
  if (node.journey) return `/journeys/${node.journey}/${node.type}/${node.id}`;
  return '/';
}
