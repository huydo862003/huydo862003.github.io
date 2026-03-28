export function formatSlug (s: string): string {
  return s.replace(/-/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase());
}

export function pct (n: number, total: number): string {
  return total ? `${(n / total * 100).toFixed(0)}%` : '0%';
}

export function plural (n: number, word: string): string {
  return `${n} ${word}${n === 1 ? '' : 's'}`;
}

export function statusProgress (status: string): string {
  if (status === 'mastered') return '100';
  if (status === 'reviewing') return '60';
  return '20';
}

export function ringColor (progress: string | number): string {
  const p = Number(progress);
  if (100 <= p) return 'var(--color-accent-green)';
  if (60 <= p) return 'var(--color-accent-yellow)';
  if (40 <= p) return 'var(--color-accent-orange)';
  if (20 <= p) return 'var(--color-accent-red)';
  return 'var(--color-border)';
}
