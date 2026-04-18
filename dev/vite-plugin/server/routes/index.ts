import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import {
  fileRoutes,
} from './file.routes';
import {
  gitRoutes,
} from './git.routes';
import {
  schemaRoutes,
} from './schema.routes';
import {
  filepathRoutes,
} from './filepath.routes';
import {
  assetsRoutes,
} from './assets.routes';
import {
  join,
} from 'node:path';

export function createRouter (manager: ContentManager, projectDir: string): Router {
  const router = Router();

  router.use(fileRoutes(manager));
  router.use(gitRoutes(projectDir));
  router.use(schemaRoutes(manager));
  router.use(filepathRoutes(manager));
  router.use(assetsRoutes(join(projectDir, 'public/assets')));

  return router;
}
