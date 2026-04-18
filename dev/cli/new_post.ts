#!/usr/bin/env node
import {
  resolve,
} from 'node:path';
import {
  input,
} from '@inquirer/prompts';
import {
  ContentManager,
} from '../core/contentManager';

const manager = new ContentManager(resolve(import.meta.dirname, '../../content'));

const author = await input({
  message: 'Author:',
  validate: (v) => v.trim() === 'hdnax' || v.trim() === 'cosmos',
});
const title = await input({
  message: 'Title:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const description = await input({
  message: 'Description (optional):',
});

const path = manager.createThought(title, {
  author,
  description: description || undefined,
});
console.log(`Created: ${path}`);
