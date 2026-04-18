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

const name = await input({
  message: 'Name:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const bio = await input({
  message: 'Bio (optional):',
});
const url = await input({
  message: 'URL (optional):',
});
const dateOfBirth = await input({
  message: 'Date of birth (YYYY-MM-DD, optional):',
});
const origin = await input({
  message: 'Origin (optional):',
});

const path = manager.createAuthor(name, {
  bio: bio || undefined,
  url: url || undefined,
  dateOfBirth: dateOfBirth || undefined,
  origin: origin || undefined,
});
console.log(`Created: ${path}`);
