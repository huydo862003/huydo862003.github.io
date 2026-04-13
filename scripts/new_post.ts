#!/usr/bin/env node
import {
  scaffoldContent,
} from './utils/scaffold';

const title = process.argv[2];
if (!title) {
  console.error('Usage: pnpm new:post "My Post Title"');
  process.exit(1);
}

const date = new Date().toISOString()
  .slice(0, 10);

scaffoldContent({
  contentDir: 'thoughts',
  title,
  frontMatter: `title: ${title}\ndate: ${date}\ndescription:\ntags: []\narchived: false\nconcepts: []\njourneys: []`,
});
