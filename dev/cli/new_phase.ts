#!/usr/bin/env node
import {
  resolve,
} from 'node:path';
import {
  input, number, select,
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
const order = await number({
  message: 'Order:',
  default: 0,
});
const status = await select({
  message: 'Status:',
  choices: [
    {
      value: 'on-hold',
    },
    {
      value: 'active',
    },
    {
      value: 'completed',
    },
  ],
});

const path = manager.createPhase(journey, title, {
  author,
  status,
  order: order ?? 0,
});
console.log(`Created: ${path}`);
