import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import {
  list,
} from '../controllers/schema.controller';

export function schemaRoutes (manager: ContentManager): Router {
  const router = Router();

  router.get('/schema', list(manager));

  return router;
}
