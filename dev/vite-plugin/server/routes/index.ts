import {
  join,
} from 'node:path';
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

export function createRouter (manager: ContentManager, projectDirectory: string): Router {
  const router = Router();

  router.use(fileRoutes(manager));
  router.use(gitRoutes(projectDirectory));
  router.use(schemaRoutes(manager));
  router.use(filepathRoutes(manager));
  router.use(assetsRoutes(join(projectDirectory, 'public/assets')));

  return router;
}
