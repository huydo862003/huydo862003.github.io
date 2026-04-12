import {
  defineStore,
} from 'pinia';
import {
  nextTick,
  ref, watch,
} from 'vue';

const themeKey = 'scrambled_theme';

export const useThemeStore = defineStore('theme', () => {
  const isDark = ref(false);

  async function init () {
    if (typeof window === 'undefined') return;
    const stored = localStorage.getItem(themeKey);
    const shouldBeDark = stored === 'dark' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches);

    if (shouldBeDark) {
      document.documentElement.classList.add('dark');
      isDark.value = true;
    }

    await nextTick();
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
    localStorage.setItem(themeKey, dark ? 'dark' : 'light');
  });

  return {
    isDark,
    toggle,
  };
});
