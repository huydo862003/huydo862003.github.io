import { Router } from 'express';
import * as assetsController from '../controllers/assets.controller';

export function assetsRoutes (assetsDir: string): Router {
  const router = Router();
  router.get('/assets', assetsController.list(assetsDir));
  router.post('/assets/upload', assetsController.upload(assetsDir));
  return router;
}
