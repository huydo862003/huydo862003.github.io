import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import {
  lookup,
} from '../controllers/filepath.controller';

export function filepathRoutes (manager: ContentManager): Router {
  const router = Router();

  router.get('/filepath', lookup(manager));

  return router;
}
