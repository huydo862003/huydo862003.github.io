const HUES = [
  40,
  20,
  30,
  50,
  140,
  210,
  270,
  330,
  0,
];

function hash (s: string): number {
  let h = 0;
  for (const ch of s) h = ((h << 5) - h + ch.charCodeAt(0)) | 0;
  return Math.abs(h);
}

export function tagHue (tag: string): number {
  return HUES[hash(tag) % HUES.length];
}
