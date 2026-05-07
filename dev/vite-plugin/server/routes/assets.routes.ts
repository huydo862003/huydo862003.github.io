import {
  Router,
} from 'express';
import {
  list, upload,
} from '../controllers/assets.controller';

export function assetsRoutes (assetsDirectory: string): Router {
  const router = Router();
  router.get('/assets', list(assetsDirectory));
  router.post('/assets/upload', upload(assetsDirectory));
  return router;
}
