import type {
  Request, Response,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';

export function list (manager: ContentManager) {
  return (_req: Request, res: Response) => {
    res.json(manager.schemas());
  };
}
