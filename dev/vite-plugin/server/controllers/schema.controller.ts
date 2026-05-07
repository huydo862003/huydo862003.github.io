import type {
  Request, Response,
} from 'express';
import type {
  ContentManager,
} from '../../../core/contentManager';

export function list (manager: ContentManager) {
  return (_request: Request, response: Response) => {
    response.json(manager.schemas());
  };
}
