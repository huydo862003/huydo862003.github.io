import {
  join,
} from 'node:path';
import {
  realpathSync,
} from 'node:fs';
import type {
  Plugin, ViteDevServer,
} from 'vite';
import express from 'express';
import cors from 'cors';
import {
  ContentManager,
} from '../core/contentManager';
import {
  EDITOR_HOST, EDITOR_PORT,
} from '../constants';
import {
  createRouter,
} from './server/routes';

export function editorPlugin (): Plugin {
  const contentDir = realpathSync(join(process.cwd(), 'content'));

  return {
    name: 'local-editor',
    apply: 'serve',
    configureServer () {
      const manager = new ContentManager(contentDir);

      const app = express();
      app.use(cors());
      app.use(express.json());
      app.use('/dev', createRouter(manager, process.cwd()));

      app.listen(EDITOR_PORT, EDITOR_HOST, () => {
        console.log(`  ->  Editor API: http://${EDITOR_HOST}:${EDITOR_PORT}/`);
      });
    },
    handleHotUpdate ({ file }) {
      if (file.startsWith(contentDir) && file.endsWith('.md')) return [];
    },
  };
}
