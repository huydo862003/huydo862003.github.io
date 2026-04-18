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

const typeQuery = z.object({ type: z.string().min(1) });

export function list (manager: ContentManager) {
  return (req: Request, res: Response) => {
    const parsed = typeQuery.safeParse(req.query);
    if (!parsed.success) return res.status(400).json({ error: parsed.error.issues[0].message });
    res.json(manager.listContent(parsed.data.type));
  };
}

export function journeyTree (manager: ContentManager) {
  return (_req: Request, res: Response) => {
    res.json(manager.journeyTree());
  };
}

export function tree (manager: ContentManager) {
  return (_req: Request, res: Response) => {
    res.json(manager.tree());
  };
}

export function get (manager: ContentManager) {
  return (req: Request, res: Response) => {
    const parsed = pathQuery.safeParse(req.query);
    if (!parsed.success) return res.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      res.json(manager.getContent(parsed.data.path));
    } catch (error) {
      if (error instanceof JailEscapeError) return res.status(403).json({
        error: 'forbidden',
      });
      return res.status(404).json({
        error: 'not found',
      });
    }
  };
}

export function update (manager: ContentManager) {
  return (req: Request, res: Response) => {
    const parsed = fileBody.safeParse(req.body);
    if (!parsed.success) return res.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      manager.updateContent(parsed.data.path, parsed.data.content);
      res.json({
        ok: true,
      });
    } catch (error) {
      if (error instanceof JailEscapeError) return res.status(403).json({
        error: 'forbidden',
      });
      return res.status(404).json({
        error: 'not found',
      });
    }
  };
}

export function remove (manager: ContentManager) {
  return (req: Request, res: Response) => {
    const parsed = pathQuery.safeParse(req.query);
    if (!parsed.success) return res.status(400).json({
      error: parsed.error.issues[0].message,
    });
    try {
      manager.deleteContent(parsed.data.path);
      res.json({
        ok: true,
      });
    } catch (error) {
      if (error instanceof JailEscapeError) return res.status(403).json({
        error: 'forbidden',
      });
      return res.status(404).json({
        error: 'not found',
      });
    }
  };
}
