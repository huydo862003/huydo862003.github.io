import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import * as filepathController from '../controllers/filepath.controller';

export function filepathRoutes (manager: ContentManager): Router {
  const router = Router();
  router.get('/filepath', filepathController.lookup(manager));
  return router;
}
