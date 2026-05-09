import {
  Router,
} from 'express';
import {
  status, commit,
} from '../controllers/git.controller';

export function gitRoutes (projectDirectory: string): Router {
  const router = Router();

  router.get('/git/status', status(projectDirectory));
  router.post('/git/commit', commit(projectDirectory));

  return router;
}
