import { defineStore } from 'pinia';
import {
  ref, watch,
} from 'vue';

export const useThemeStore = defineStore('theme', () => {
  const isDark = ref(false);

  function init () {
    if (typeof window === 'undefined') return;
    const stored = localStorage.getItem('scrambled_theme');
    if (stored === 'dark' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      isDark.value = true;
    }
  }

  function toggle () {
    isDark.value = !isDark.value;
  }

  if (typeof window !== 'undefined') {
    init();
  }

  watch(isDark, (dark) => {
    if (typeof document === 'undefined') return;
    document.documentElement.classList.toggle('dark', dark);
    localStorage.setItem('scrambled_theme', dark ? 'dark' : 'light');
  }, { immediate: true });

  return {
    isDark,
    toggle,
  };
});
