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

const globalBindings = ref<KeyBinding[]>([]);

function matches (event: KeyboardEvent, binding: KeyBinding): boolean {
  return event.key.toLowerCase() === binding.key.toLowerCase()
    && !!binding.meta === (event.metaKey || event.ctrlKey)
    && !!binding.shift === event.shiftKey
    && !!binding.alt === event.altKey;
}

function onKeyDown (event: KeyboardEvent) {
  for (const binding of globalBindings.value) {
    if (matches(event, binding)) {
      event.preventDefault();
      binding.handler();

      return;
    }
  }
}

let listening = false;

export function formatShortcut (binding: KeyBinding): string[] {
  const parts: string[] = [];

  if (binding.meta) parts.push(navigator?.platform?.includes('Mac') ? '⌘' : 'Ctrl');
  if (binding.shift) parts.push('⇧');
  if (binding.alt) parts.push(navigator?.platform?.includes('Mac') ? '⌥' : 'Alt');
  parts.push(binding.key.length === 1 ? binding.key.toUpperCase() : binding.key);

  return parts;
}

export function useKeyboard () {
  if (!listening && typeof window !== 'undefined') {
    window.addEventListener('keydown', onKeyDown);
    listening = true;
  }

  function register (bindings: KeyBinding[]) {
    globalBindings.value.push(...bindings);
    onUnmounted(() => {
      globalBindings.value = globalBindings.value.filter((binding) => !bindings.includes(binding));
    });
  }

  return {
    register,
    bindings: globalBindings,
  };
}
