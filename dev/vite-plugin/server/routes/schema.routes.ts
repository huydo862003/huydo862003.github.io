import {
  Router,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';
import * as schemaController from '../controllers/schema.controller';

export function schemaRoutes (manager: ContentManager): Router {
  const router = Router();
  router.get('/schema', schemaController.list(manager));
  return router;
}
