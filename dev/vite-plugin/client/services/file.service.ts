import type {
  FileData,
} from '@dev/core/types';
import {
  httpClient,
} from './http.client';

export type {
  FileData,
} from '@dev/core/types';

export async function openFile (path: string): Promise<FileData> {
  const {
    data,
  } = await httpClient.get('/file', {
    params: {
      path,
    },
  });
  return data;
}

export async function updateFile (path: string, content: string): Promise<void> {
  await httpClient.put('/file', {
    path,
    content,
  });
}

export async function createFile (path: string, content: string): Promise<string> {
  const {
    data,
  } = await httpClient.post('/file', {
    path,
    content,
  });
  return data.path;
}

export async function deleteFile (path: string): Promise<void> {
  await httpClient.delete('/file', {
    params: {
      path,
    },
  });
}

export async function resolveFilepath (route: string): Promise<string> {
  const {
    data,
  } = await httpClient.get('/filepath', {
    params: {
      route,
    },
  });
  return data.path;
}
