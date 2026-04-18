import type { TreeNode, JourneyTree } from '@dev/core/types';
import { httpClient } from './http.client';

export type { TreeNode, JourneyTree, JourneyGroup, ContentItem } from '@dev/core/types';

export async function loadTree (): Promise<TreeNode[]> {
  const { data } = await httpClient.get('/tree');
  return data;
}

export async function loadJourneyTree (): Promise<JourneyTree> {
  const { data } = await httpClient.get('/journey-tree');
  return data;
}
