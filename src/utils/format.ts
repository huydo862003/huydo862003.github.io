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
  const progressValue = Number(progress);
  if (100 <= progressValue) return 'var(--gui-success-solid)';
  if (60 <= progressValue) return 'var(--gui-warning-solid)';
  if (40 <= progressValue) return 'var(--gui-notice-solid)';
  if (20 <= progressValue) return 'var(--gui-danger-solid)';
  return 'var(--gui-neutral-border)';
}
