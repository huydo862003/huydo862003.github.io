#!/usr/bin/env node
import {
  resolve,
} from 'node:path';
import {
  input, select,
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
const status = await select({
  message: 'Status:',
  choices: [
    {
      value: 'active',
    },
    {
      value: 'paused',
    },
    {
      value: 'completed',
    },
  ],
});

const path = manager.createJourney(title, {
  author,
  status,
});
console.log(`Created: ${path}`);
