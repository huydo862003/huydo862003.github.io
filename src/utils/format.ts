export function formatSlug (slug: string): string {
  return slug.replace(/-/g, ' ').replace(/\b\w/g, (char) => char.toUpperCase());
}

export function pct (n: number, total: number): string {
  return total ? `${(n / total * 100).toFixed(0)}%` : '0%';
}

export function plural (n: number, word: string): string {
  return `${n} ${word}${n === 1 ? '' : 's'}`;
}

export function ringColor (progress: string | number): string {
  const progressValue = Number(progress);

  if (100 <= progressValue) return 'var(--gui-success-solid)';
  if (60 <= progressValue) return 'var(--gui-warning-solid)';
  if (40 <= progressValue) return 'var(--gui-notice-solid)';
  if (20 <= progressValue) return 'var(--gui-danger-solid)';

  return 'var(--gui-neutral-border)';
}

export function statusProgress (status: string): string {
  if (status === 'mastered') return '100';
  if (status === 'reviewing') return '60';

  return '20';
}
