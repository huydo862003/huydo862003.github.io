#!/usr/bin/env node
import {
  input, select,
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
const description = await input({
  message: 'Description (optional):',
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

scaffoldContent({
  contentDir: 'concepts',
  title,
  author,
  frontMatter: `title: "${title}"\njourney: "${journey}"\ndescription: "${description}"\nstatus: ${status}\ntags: []\nkeywords: []\nbooks: []\ndependsOn: []\nblocks: []`,
});
