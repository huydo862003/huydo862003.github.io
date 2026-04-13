#!/usr/bin/env node
import {
  input,
} from '@inquirer/prompts';
import {
  scaffoldContent,
} from './utils/scaffold';

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

scaffoldContent({
  contentDir: 'authors',
  title: name,
  author: name,
  frontMatter: `name: "${name}"\nbio: "${bio}"\nurl: "${url}"\ndateOfBirth: "${dateOfBirth}"\norigin: "${origin}"\neducation: []\ninterests: []\ntags: []`,
});
