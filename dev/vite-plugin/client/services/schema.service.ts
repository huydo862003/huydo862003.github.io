import type {
  ContentSchema,
} from '@dev/core/types';
import {
  httpClient,
} from './http.client';

export type {
  FieldSchema, EnumDef, ContentSchema,
} from '@dev/core/types';

export async function loadSchemas (): Promise<Record<string, ContentSchema>> {
  const {
    data,
  } = await httpClient.get('/schema');
  return data;
}
