#!/usr/bin/env node
import {
  scaffoldContent,
} from './utils/scaffold';

const title = process.argv[2];
const journey = process.argv[3] || '';
const order = process.argv[4] || '0';

if (!title) {
  console.error('Usage: pnpm new:phase "Phase Title" [journey-slug] [order]');
  process.exit(1);
}

scaffoldContent({
  contentDir: 'phases',
  title,
  frontMatter: `title: ${title}\njourney: ${journey}\nstatus: on-hold\norder: ${order}\nbooks: []\nconcepts: []`,
});
