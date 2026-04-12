import {
  onUnmounted, ref,
} from 'vue';

export interface KeyBinding {
  key: string;
  meta?: boolean;
  shift?: boolean;
  ctrl?: boolean;
  alt?: boolean;
  handler: () => void;
  label: string;
  scope: 'global' | 'page';
}

const globalBindings = ref<KeyBinding[]>([
]);

function matches (e: KeyboardEvent, b: KeyBinding): boolean {
  return e.key.toLowerCase() === b.key.toLowerCase()
    && !!b.meta === (e.metaKey || e.ctrlKey)
    && !!b.shift === e.shiftKey
    && !!b.alt === e.altKey;
}

function onKeyDown (e: KeyboardEvent) {
  for (const b of globalBindings.value) {
    if (matches(e, b)) {
      e.preventDefault();
      b.handler();
      return;
    }
  }
}

let listening = false;

export function useKeyboard () {
  if (!listening && typeof window !== 'undefined') {
    window.addEventListener('keydown', onKeyDown);
    listening = true;
  }

  function register (bindings: KeyBinding[]) {
    globalBindings.value.push(...bindings);
    onUnmounted(() => {
      globalBindings.value = globalBindings.value.filter((b) => !bindings.includes(b));
    });
  }

  return {
    register,
    bindings: globalBindings,
  };
}

export function formatShortcut (b: KeyBinding): string[] {
  const parts: string[] = [
  ];
  if (b.meta) parts.push(navigator?.platform?.includes('Mac') ? '⌘' : 'Ctrl');
  if (b.shift) parts.push('⇧');
  if (b.alt) parts.push(navigator?.platform?.includes('Mac') ? '⌥' : 'Alt');
  parts.push(b.key.length === 1 ? b.key.toUpperCase() : b.key);
  return parts;
}
