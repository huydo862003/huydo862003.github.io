#!/usr/bin/env node
import {
  input,
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
const date = new Date().toISOString()
  .slice(0, 10);

scaffoldContent({
  contentDir: 'thoughts',
  title,
  frontMatter: `title: "${title}"\ndate: ${date}\ndescription: "${description}"\ntags: []\narchived: false\nconcepts: []\njourneys: []`,
});
