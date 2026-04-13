#!/usr/bin/env node
import {
  input,
} from '@inquirer/prompts';
import {
  scaffoldContent,
} from './utils/scaffold';

const author = await input({
  message: 'Author:',
  validate: (v) => v.trim() === 'hdnax' || v.trim() === 'cosmos',
});
const question = await input({
  message: 'Question:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const answer = await input({
  message: 'Answer:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const deck = await input({
  message: 'Deck:',
  default: 'general',
});

scaffoldContent({
  contentDir: 'flashcards',
  title: question,
  author,
  frontMatter: `question: "${question}"\nanswer: "${answer}"\ndeck: "${deck}"\ntags: []\nkeywords: []\nconcepts: []\nbooks: []`,
});
