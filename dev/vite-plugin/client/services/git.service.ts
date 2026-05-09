import type {
  GitFile,
} from '@dev/core/types';
import {
  httpClient,
} from './http.client';

export type {
  GitFile,
} from '@dev/core/types';

export async function fetchGitStatus (): Promise<GitFile[]> {
  const {
    data,
  } = await httpClient.get('/git/status');

  return data.files;
}

export async function submitCommit (message: string, files?: string[]): Promise<void> {
  await httpClient.post('/git/commit', {
    message,
    files,
  });
}
