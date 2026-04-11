<template>
  <nav class="nav">
    <div class="inner">
      <router-link
        to="/"
        class="logo"
      >
        <SLogo class="logo-icon" />
        <span class="logo-text">scrambled</span>
      </router-link>
      <div class="right">
        <router-link
          v-for="link in navLinks"
          :key="link.to"
          :to="link.to"
          class="nav-link"
        >
          {{ link.label }}
        </router-link>
        <VTooltip placement="bottom">
          <button
            class="icon-btn"
            @click="emit('open-palette')"
          >
            <PhMagnifyingGlass
              :size="16"
              weight="bold"
            />
          </button>
          <template #popper>
            <span class="tooltip-search">Search <SKbdShortcut :keys="['Alt', 'P']" /></span>
          </template>
        </VTooltip>
        <button
          class="icon-btn"
          :title="isDark ? 'Light mode' : 'Dark mode'"
          @click="toggle"
        >
          <PhMoon
            v-if="!isDark"
            :size="16"
            weight="bold"
          />
          <PhSun
            v-else
            :size="16"
            weight="bold"
          />
        </button>
        <UserMenu />
      </div>
      <div class="mobile-right">
        <button
          class="icon-btn"
          @click="open = !open"
        >
          <PhX
            v-if="open"
            :size="18"
            weight="bold"
          />
          <PhList
            v-else
            :size="18"
            weight="bold"
          />
        </button>
        <button
          class="icon-btn"
          @click="toggle"
        >
          <PhMoon
            v-if="!isDark"
            :size="16"
            weight="bold"
          />
          <PhSun
            v-else
            :size="16"
            weight="bold"
          />
        </button>
        <UserMenu />
      </div>
    </div>
    <div
      v-if="open"
      class="mobile-menu"
    >
      <router-link
        v-for="link in navLinks"
        :key="link.to"
        :to="link.to"
        class="mobile-link"
        @click="open = false"
      >
        {{ link.label }}
      </router-link>
    </div>
  </nav>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import {
  PhSun, PhMoon, PhList, PhX, PhMagnifyingGlass,
} from '@phosphor-icons/vue';
import { useThemeStore } from '@/stores/theme';
import SLogo from '@/components/common/SLogo.vue';
import UserMenu from '@/components/layout/UserMenu.vue';
import SKbdShortcut from '@/components/common/SKbdShortcut.vue';

const emit = defineEmits<{ (e: 'open-palette'): void }>();

const themeStore = useThemeStore();
const { isDark } = storeToRefs(themeStore);
const { toggle } = themeStore;
const open = ref(false);

const navLinks = [
  {
    label: 'Thoughts',
    to: '/thoughts',
  },
  {
    label: 'Journeys',
    to: '/journeys',
  },
  {
    label: 'Reads',
    to: '/reads',
  },
];
</script>

<style scoped>
@reference "../../style.css";
.nav {
  @apply border-b border-border bg-bg;
}
.inner {
  max-width: 64rem;
  margin: 0 auto;
  padding: 0 1rem;
  height: 3rem;
  display: flex;
  align-items: center;
}
.logo {
  @apply no-underline flex items-center gap-0.5;
}
.logo-icon {
  @apply h-14 w-14 text-fg;
}
.logo-text {
  @apply text-sm font-bold;
}
.right {
  @apply hidden sm:flex items-center gap-4 ml-auto;
}
.nav-link {
  @apply text-xs text-fg-muted no-underline hover:text-fg;
}
.icon-btn {
  @apply text-fg-faint hover:text-fg p-1 cursor-pointer;
}
.mobile-right {
  @apply sm:hidden flex items-center gap-1 ml-auto;
}
.mobile-menu {
  @apply sm:hidden border-t border-border-muted px-4 py-2 flex flex-col gap-1;
}
.mobile-link {
  @apply text-sm text-fg-muted no-underline hover:text-fg py-1;
}
.tooltip-search {
  @apply flex items-center gap-2 text-xs text-fg-muted;
}
</style>
