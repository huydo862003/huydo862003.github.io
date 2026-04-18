// re-export generated types as the single source of truth
export {
  ContentType,
} from './__generated__/schemas';
export type {
  Authors, Blogs, Books, Concepts, Flashcards,
  Journeys, Papers, Phases, Thoughts,
} from './__generated__/schemas';

// UI/API types not derived from YAML
export interface TreeNode {
  name: string;
  path: string;
  type: 'file' | 'dir';
  children?: TreeNode[];
}

export interface FieldSchema {
  type: 'string' | 'boolean' | 'number' | 'enum' | 'array' | 'date';
  default?: unknown;
  enum?: string;
  conditionOn?: string;
  itemType?: string;
  required?: boolean;
  label?: string;
  ref?: string;
  multi?: boolean;
  hidden?: boolean;
}

export type EnumDef = string[] | Record<string, string[]>;

export interface ContentSchema {
  id: string;
  displayName: string;
  enums: Record<string, EnumDef>;
  fields: Record<string, FieldSchema>;
}

export interface FileData {
  path: string;
  content: string;
}

export interface GitFile {
  status: string;
  path: string;
}
