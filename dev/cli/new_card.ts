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
  validate: (value) => value.trim() === 'hdnax' || v.trim() === 'cosmos',
});
const journey = await input({
  message: 'Journey slug:',
  validate: (value) => value.trim() !== '' || 'Required',
});
const question = await input({
  message: 'Question:',
  validate: (value) => value.trim() !== '' || 'Required',
});
const deck = await input({
  message: 'Deck:',
  default: 'general',
});

const path = manager.createFlashcard(journey, question, {
  author,
  deck,
});
console.log(`Created: ${path}`);
