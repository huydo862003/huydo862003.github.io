import type {
  Request, Response,
} from 'express';
import {
  z,
} from 'zod';
import type {
  ContentManager,
} from '../../../core/contentManager';
import {
  JailEscapeError,
} from '../../../core/rootJail';

const pathQuery = z.object({
  path: z.string().min(1),
});
const fileBody = z.object({
  path: z.string().min(1),
  content: z.string(),
});

const typeQuery = z.object({
  type: z.string().min(1),
});

export function list (manager: ContentManager) {
  return (request: Request, response: Response) => {
    const parsed = typeQuery.safeParse(request.query);
    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    response.json(manager.listContent(parsed.data.type));
  };
}

export function journeyTree (manager: ContentManager) {
  return (_request: Request, response: Response) => {
    response.json(manager.journeyTree());
  };
}

export function tree (manager: ContentManager) {
  return (_request: Request, response: Response) => {
    response.json(manager.tree());
  };
}

export function get (manager: ContentManager) {
  return (request: Request, response: Response) => {
    const parsed = pathQuery.safeParse(request.query);
    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      response.json(manager.getContent(parsed.data.path));
    } catch (error) {
      if (error instanceof JailEscapeError) return response.status(403).json({
        error: 'forbidden',
      });
      return response.status(404).json({
        error: 'not found',
      });
    }
  };
}

export function update (manager: ContentManager) {
  return (request: Request, response: Response) => {
    const parsed = fileBody.safeParse(request.body);
    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      manager.updateContent(parsed.data.path, parsed.data.content);
      response.json({
        ok: true,
      });
    } catch (error) {
      if (error instanceof JailEscapeError) return response.status(403).json({
        error: 'forbidden',
      });
      return response.status(404).json({
        error: 'not found',
      });
    }
  };
}

export function remove (manager: ContentManager) {
  return (request: Request, response: Response) => {
    const parsed = pathQuery.safeParse(request.query);
    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      manager.deleteContent(parsed.data.path);
      response.json({
        ok: true,
      });
    } catch (error) {
      if (error instanceof JailEscapeError) return response.status(403).json({
        error: 'forbidden',
      });
      return response.status(404).json({
        error: 'not found',
      });
    }
  };
}
