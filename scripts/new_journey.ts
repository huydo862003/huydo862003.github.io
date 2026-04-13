#!/usr/bin/env node
import {
  scaffoldContent,
} from './utils/scaffold';

const title = process.argv[2];
if (!title) {
  console.error('Usage: pnpm new:journey "Journey Title"');
  process.exit(1);
}

scaffoldContent({
  contentDir: 'journeys',
  title,
  frontMatter: `title: ${title}\ndescription:\nstatus: active\ntags: []`,
});
