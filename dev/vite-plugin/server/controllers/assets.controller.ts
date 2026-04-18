import { basename } from 'node:path';
import { existsSync, mkdirSync, readdirSync } from 'node:fs';
import type { Request, Response } from 'express';
import multer from 'multer';

export function upload (assetsDir: string) {
  if (!existsSync(assetsDir)) mkdirSync(assetsDir, { recursive: true });

  const storage = multer.diskStorage({
    destination: assetsDir,
    filename: (_req, file, cb) => cb(null, basename(file.originalname)),
  });

  const uploader = multer({ storage }).single('file');

  return (req: Request, res: Response) => {
    uploader(req, res, (err) => {
      if (err) return res.status(500).json({ error: err.message });
      if (!req.file) return res.status(400).json({ error: 'no file' });
      // return path relative to public/ so it works as a URL
      const rel = '/assets/' + req.file.filename;
      res.json({ path: rel });
    });
  };
}

export function list (assetsDir: string) {
  return (_req: Request, res: Response) => {
    if (!existsSync(assetsDir)) return res.json({ files: [] });
    const files = readdirSync(assetsDir)
      .filter((f) => !f.startsWith('.'))
      .map((f) => ({ name: f, url: `/assets/${f}` }));
    res.json({ files });
  };
}
