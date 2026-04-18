import {
  readFileSync, writeFileSync, readdirSync, statSync, existsSync,
  unlinkSync, realpathSync, lstatSync, mkdirSync,
} from 'node:fs';
import {
  join, normalize, resolve, sep,
} from 'node:path';

export class JailEscapeError extends Error {
  constructor (path: string, root: string) {
    super(`path "${path}" escapes jail root "${root}"`);
    this.name = 'JailEscapeError';
  }
}

// lightweight fs wrapper with path containment
// blocks ../ traversal, null bytes, and symlink escape
export class RootJail {
  readonly root: string;

  constructor (root: string) {
    const resolved = realpathSync(normalize(root));
    if (!statSync(resolved).isDirectory()) throw new Error(`root must be a directory: ${resolved}`);
    this.root = resolved.endsWith(sep) ? resolved : resolved + sep;
  }

  private inside (abs: string): boolean {
    return abs === this.root.slice(0, -1) || abs.startsWith(this.root);
  }

  // resolve relative path to contained absolute path, throws on escape
  resolve (p: string): string {
    if (/\0/.test(p)) throw new JailEscapeError(p, this.root);
    const contained = normalize(resolve(this.root, p));
    if (!this.inside(contained)) throw new JailEscapeError(p, this.root);

    if (existsSync(contained)) {
      const real = realpathSync(contained);
      if (!this.inside(real)) throw new JailEscapeError(p, this.root);
      return real;
    }

    // new path: check nearest existing ancestor
    let ancestor = contained;
    while (!existsSync(ancestor)) {
      const parent = join(ancestor, '..');
      if (parent === ancestor) throw new JailEscapeError(p, this.root);
      ancestor = parent;
    }
    if (!this.inside(realpathSync(ancestor))) throw new JailEscapeError(p, this.root);
    return contained;
  }

  isUnsafeSymlink (abs: string): boolean {
    try {
      const stat = lstatSync(abs);
      if (!stat.isSymbolicLink()) return false;
      return !this.inside(realpathSync(abs));
    } catch {
      return true;
    }
  }

  // fs wrappers - all take jail-relative paths, all throw on escape
  existsSync (p: string): boolean {
    return existsSync(this.resolve(p));
  }

  readFileSync (p: string): string {
    return readFileSync(this.resolve(p), 'utf-8');
  }

  // always creates new - throws if file already exists
  writeFileSync (p: string, content: string): void {
    const abs = this.resolve(p);
    if (existsSync(abs)) throw new Error(`file already exists: ${p}`);
    writeFileSync(abs, content, 'utf-8');
  }

  mkdirSync (p: string): void {
    mkdirSync(this.resolve(p), {
      recursive: true,
    });
  }

  unlinkSync (p: string): void {
    unlinkSync(this.resolve(p));
  }

  readdirSync (p: string): string[] {
    return readdirSync(this.resolve(p));
  }

  statSync (p: string): ReturnType<typeof statSync> {
    return statSync(this.resolve(p));
  }
}
