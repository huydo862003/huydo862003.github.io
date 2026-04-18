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
const journey = await input({
  message: 'Journey slug:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const status = await select({
  message: 'Status:',
  choices: [
    {
      value: 'learning',
    },
    {
      value: 'reviewing',
    },
    {
      value: 'mastered',
    },
  ],
});

const path = manager.createConcept(journey, title, {
  author,
  status,
});
console.log(`Created: ${path}`);
