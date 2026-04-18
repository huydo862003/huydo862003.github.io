import type {
  TreeNode,
} from '@dev/core/types';
import {
  httpClient,
} from './http.client';

export type {
  TreeNode,
} from '@dev/core/types';

export async function loadTree (): Promise<TreeNode[]> {
  const {
    data,
  } = await httpClient.get('/tree');
  return data;
}
