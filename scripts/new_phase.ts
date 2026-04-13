#!/usr/bin/env node
import {
  input, number, select,
} from '@inquirer/prompts';
import {
  scaffoldContent,
} from './utils/scaffold';

const author = await input({
  message: 'Author:',
  validate: (v) => v.trim() === 'hdnax' || v.trim() === 'cosmos',
});
const title = await input({
  message: 'Title:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const journey = await input({
  message: 'Journey slug (optional):',
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

scaffoldContent({
  contentDir: 'phases',
  title,
  author,
  frontMatter: `title: "${title}"\njourney: "${journey}"\nstatus: ${status}\norder: ${order}\nbooks: []\nconcepts: []`,
});
