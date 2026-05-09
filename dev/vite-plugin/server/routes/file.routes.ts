import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import {
  tree, journeyTree, list, get, update, remove,
} from '../controllers/file.controller';

export function fileRoutes (manager: ContentManager): Router {
  const router = Router();

  router.get('/tree', tree(manager));
  router.get('/journey-tree', journeyTree(manager));
  router.get('/list', list(manager));
  router.get('/file', get(manager));
  router.put('/file', update(manager));
  router.delete('/file', remove(manager));

  return router;
}
