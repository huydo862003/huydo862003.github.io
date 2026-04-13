#!/usr/bin/env node
import {
  scaffoldContent,
} from './utils/scaffold';

const title = process.argv[2];
const journey = process.argv[3] || '';
if (!title) {
  console.error('Usage: pnpm new:concept "Concept Name" [journey-slug]');
  process.exit(1);
}

scaffoldContent({
  contentDir: 'concepts',
  title,
  frontMatter: `title: ${title}\njourney: ${journey}\ndescription: ""\nstatus: learning\ntags: []\nkeywords: []\nbooks: []\ndependsOn: []\nblocks: []`,
});
