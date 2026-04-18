import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import * as fileController from '../controllers/file.controller';

export function fileRoutes (manager: ContentManager): Router {
  const router = Router();
  router.get('/tree', fileController.tree(manager));
  router.get('/list', fileController.list(manager));
  router.get('/file', fileController.get(manager));
  router.put('/file', fileController.update(manager));
  router.delete('/file', fileController.remove(manager));
  return router;
}
