import {
  basename,
} from 'node:path';
import {
  existsSync, mkdirSync, readdirSync,
} from 'node:fs';
import type {
  Request, Response,
} from 'express';
import multer from 'multer';

export function list (assetsDirectory: string) {
  return (_request: Request, response: Response) => {
    if (!existsSync(assetsDirectory)) return response.json({
      files: [],
    });
    const files = readdirSync(assetsDirectory)
      .filter((file) => !file.startsWith('.'))
      .map((file) => ({
        name: file,
        url: `/assets/${file}`,
      }));

    response.json({
      files,
    });
  };
}

export function upload (assetsDirectory: string) {
  if (!existsSync(assetsDirectory)) mkdirSync(assetsDirectory, {
    recursive: true,
  });

  const storage = multer.diskStorage({
    destination: assetsDirectory,
    filename: (_request, file, callback) => callback(null, basename(file.originalname)),
  });

  const uploader = multer({
    storage,
  }).single('file');

  return (request: Request, response: Response) => {
    uploader(request, response, (error) => {
      if (error) return response.status(500).json({
        error: error.message,
      });
      if (!request.file) return response.status(400).json({
        error: 'no file',
      });
      // return path relative to public/ so it works as a URL
      const relative = '/assets/' + request.file.filename;

      response.json({
        path: relative,
      });
    });
  };
}
