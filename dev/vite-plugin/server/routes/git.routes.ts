import {
  Router,
} from 'express';
import * as gitController from '../controllers/git.controller';

export function gitRoutes (projectDir: string): Router {
  const router = Router();
  router.get('/git/status', gitController.status(projectDir));
  router.post('/git/commit', gitController.commit(projectDir));
  return router;
}
