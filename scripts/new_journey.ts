#!/usr/bin/env node
import {
  input, select,
} from '@inquirer/prompts';
import {
  scaffoldContent,
} from './utils/scaffold';

const title = await input({
  message: 'Title:',
  validate: (v) => v.trim() !== '' || 'Required',
});
const description = await input({
  message: 'Description (optional):',
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

scaffoldContent({
  contentDir: 'journeys',
  title,
  frontMatter: `title: "${title}"\ndescription: "${description}"\nstatus: ${status}\ntags: []`,
});
