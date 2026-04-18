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

export function status (projectDir: string) {
  return (_req: Request, res: Response) => {
    const output = execSync('git status --porcelain content/', {
      cwd: projectDir,
      encoding: 'utf-8',
    });
    const files = output.trim().split('\n')
      .filter(Boolean)
      .map((line) => ({
        status: line.substring(0, 2).trim(),
        path: line.substring(3),
      }));
    res.json({
      files,
    });
  };
}

export function commit (projectDir: string) {
  return (req: Request, res: Response) => {
    const parsed = commitBody.safeParse(req.body);
    if (!parsed.success) return res.status(400).json({
      error: parsed.error.issues[0].message,
    });
    const {
      message, files,
    } = parsed.data;
    if (files && 0 < files.length) {
      execFileSync('git', ['add', ...files.map((f) => join('content', f))], { cwd: projectDir });
    } else {
      execFileSync('git', ['add', 'content/'], { cwd: projectDir });
    }
    execFileSync('git', ['commit', '-m', message], { cwd: projectDir });
    res.json({
      ok: true,
    });
  };
}
