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
  let hashCode = 0;
  for (const ch of s) hashCode = ((hashCode << 5) - hashCode + ch.charCodeAt(0)) | 0;
  return Math.abs(hashCode);
}

export function tagHue (tag: string): number {
  return HUES[hash(tag) % HUES.length];
}
