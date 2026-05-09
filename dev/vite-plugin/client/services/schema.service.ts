import type {
  ContentSchema,
} from '@dev/core/types';
import {
  httpClient,
} from './http.client';

export type {
  FieldSchema, EnumDefinition, ContentSchema,
} from '@dev/core/types';

export async function fetchSchemas (): Promise<Record<string, ContentSchema>> {
  const {
    data,
  } = await httpClient.get('/schema');

  return data;
}
