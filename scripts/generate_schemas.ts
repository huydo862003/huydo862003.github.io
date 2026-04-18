#!/usr/bin/env node
// reads content/.schemas/*.yaml -> generates dev/core/__generated__/schemas.ts
// output contains Zod schemas + inferred TS types for each content type

import {
  readFileSync, readdirSync, writeFileSync, mkdirSync, existsSync,
} from 'node:fs';
import {
  join, resolve,
} from 'node:path';
import yaml from 'js-yaml';

const ROOT = resolve(import.meta.dirname, '..');
const SCHEMAS_DIR = join(ROOT, 'content/.schemas');
const OUT_DIR = join(ROOT, 'dev/core/__generated__');
const OUT_FILE = join(OUT_DIR, 'schemas.ts');

interface FieldDef {
  type: string;
  required?: boolean;
  default?: unknown;
  enum?: string;
  conditionOn?: string;
  itemType?: string;
  label?: string;
  ref?: string;
}

interface SchemaDef {
  id: string;
  enums: Record<string, string[] | Record<string, string[]>>;
  fields: Record<string, FieldDef>;
}

// collect all flat enum values across all schemas for Zod enum generation
function flattenEnum (enumDef: string[] | Record<string, string[]>): string[] {
  if (Array.isArray(enumDef)) return enumDef;
  const all = new Set<string>();
  for (const values of Object.values(enumDef)) {
    for (const v of values) all.add(v);
  }
  return [...all];
}

function fieldToZod (field: FieldDef, schema: SchemaDef): string {
  let zod: string;

  switch (field.type) {
    case 'string':
      zod = 'z.string()';
      break;
    case 'number':
      zod = 'z.number()';
      break;
    case 'boolean':
      zod = 'z.boolean()';
      break;
    case 'date':
      zod = 'z.string()';
      break;
    case 'enum': {
      if (!field.enum) throw new Error('enum field missing \'enum\' key');
      if (!schema.enums[field.enum]) throw new Error(`unknown enum '${field.enum}'`);
      const values = flattenEnum(schema.enums[field.enum]);
      zod = `z.enum([${values.map((v) => `'${v}'`).join(', ')}])`;
      break;
    }
    case 'array':
      zod = 'z.array(z.string())';
      break;
    default:
      throw new Error(`unknown field type '${field.type}'`);
  }

  if (field.default !== undefined) {
    const def = typeof field.default === 'string'
      ? `'${field.default}'`
      : JSON.stringify(field.default);
    zod += `.default(${def})`;
  } else if (!field.required) {
    // non-required without default: add a sensible default
    switch (field.type) {
      case 'string':
      case 'date':
        zod += '.default(\'\')';
        break;
      case 'number':
        zod += '.default(0)';
        break;
      case 'boolean':
        zod += '.default(false)';
        break;
      case 'array':
        zod += '.default([])';
        break;
      case 'enum':
        // first value as default
        if (field.enum && schema.enums[field.enum]) {
          const values = flattenEnum(schema.enums[field.enum]);
          if (0 < values.length) zod += `.default('${values[0]}')`;
        }
        break;
    }
  }

  return zod;
}

function generateContentType (name: string): string {
  return name.charAt(0).toUpperCase() + name.slice(1);
}

function generate () {
  const files = readdirSync(SCHEMAS_DIR).filter((f) => f.endsWith('.yaml') || f.endsWith('.yml'));
  const schemas: Record<string, SchemaDef> = {};

  for (const file of files) {
    const name = file.replace(/\.ya?ml$/, '');
    schemas[name] = yaml.load(readFileSync(join(SCHEMAS_DIR, file), 'utf-8')) as SchemaDef;
  }

  const lines: string[] = [
    '// AUTO-GENERATED from content/.schemas/*.yaml',
    '// do not edit manually - run `pnpm run codegen` to regenerate',
    '',
    'import { z } from \'zod\';',
    '',
    '// common fields shared by all content types',
    'const dates = {',
    '  createdAt: z.string().default(\'\'),',
    '  updatedAt: z.string().default(\'\'),',
    '  author: z.string().default(\'\'),',
    '  published: z.boolean().default(false),',
    '};',
    '',
  ];

  const schemaNames: string[] = [];

  for (const [
    name,
    schema,
  ] of Object.entries(schemas)) {
    const typeName = generateContentType(name);
    const varName = `${name}Schema`;
    schemaNames.push(name);

    lines.push(`export const ${varName} = z.object({`);
    lines.push('  ...dates,');

    for (const [
      fieldName,
      field,
    ] of Object.entries(schema.fields)) {
      lines.push(`  ${fieldName}: ${fieldToZod(field, schema)},`);
    }

    lines.push('  content: z.string(),');
    lines.push('});');
    lines.push(`export type ${typeName} = z.infer<typeof ${varName}>;`);
    lines.push('');
  }

  // export a map of all schemas for runtime use
  lines.push('export const allSchemas = {');
  for (const name of schemaNames) {
    lines.push(`  ${name}: ${name}Schema,`);
  }
  lines.push('} as const;');
  lines.push('');

  // export content type enum
  lines.push('export enum ContentType {');
  for (const name of schemaNames) {
    lines.push(`  ${generateContentType(name)} = '${name}',`);
  }
  lines.push('}');
  lines.push('');

  if (!existsSync(OUT_DIR)) mkdirSync(OUT_DIR, {
    recursive: true,
  });
  writeFileSync(OUT_FILE, lines.join('\n'));
  console.log(`Generated: ${OUT_FILE}`);
}

generate();
