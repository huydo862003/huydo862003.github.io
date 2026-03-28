#!/usr/bin/env node
import { scaffoldContent } from './utils/scaffold';

const question = process.argv[2];
const answer = process.argv[3];
const deck = process.argv[4] || 'default';

if (!question || !answer) {
  console.error('Usage: pnpm new:card "Question" "Answer" [deck]');
  process.exit(1);
}

scaffoldContent({
  contentDir: 'flashcards',
  title: question,
  frontMatter: `question: "${question}"\nanswer: "${answer}"\ndeck: ${deck}\nconcepts: []\nbooks: []`,
});
