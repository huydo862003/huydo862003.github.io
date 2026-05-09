import {
  join,
} from 'node:path';
import {
  execFileSync, execSync,
} from 'node:child_process';
import type {
  Request, Response,
} from 'express';
import {
  z,
} from 'zod';

const commitBody = z.object({
  message: z.string().min(1),
  files: z.array(z.string()).optional(),
});

export function commit (projectDirectory: string) {
  return (request: Request, response: Response) => {
    const parsed = commitBody.safeParse(request.body);

    if (!parsed.success) return response.status(400).json({
      error: parsed.error.issues[0].message,
    });
    const {
      message, files,
    } = parsed.data;

    if (files && 0 < files.length) {
      execFileSync('git', [
        'add',
        ...files.map((file) => join('content', file)),
      ], {
        cwd: projectDirectory,
      });
    } else {
      execFileSync('git', [
        'add',
        'content/',
      ], {
        cwd: projectDirectory,
      });
    }
    execFileSync('git', [
      'commit',
      '-m',
      message,
    ], {
      cwd: projectDirectory,
    });
    response.json({
      ok: true,
    });
  };
}

export function status (projectDirectory: string) {
  return (_request: Request, response: Response) => {
    const output = execSync('git status --porcelain content/', {
      cwd: projectDirectory,
      encoding: 'utf-8',
    });
    const files = output.trim().split('\n')
      .filter(Boolean)
      .map((line) => ({
        status: line.substring(0, 2).trim(),
        path: line.substring(3),
      }));

    response.json({
      files,
    });
  };
}
