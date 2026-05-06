<template>
  <nav class="nav">
    <div class="inner">
      <router-link
        to="/"
        class="logo"
      >
        <SiteLogo class="logo-icon" />
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
            aria-label="Open search"
            @click="emit('open-palette')"
          >
            <GIcon
              :name="GIconName.Search"
              :size="16"
              weight="bold"
            />
          </button>
          <template #popper>
            <span class="tooltip-search">Search <GKbdShortcut :keys="[GKbdKeyName.Alt, GKbdKeyName.P]" /></span>
          </template>
        </VTooltip>
        <button
          class="icon-btn"
          :title="isDark ? 'Light mode' : 'Dark mode'"
          @click="toggle"
        >
          <GIcon
            v-if="!isDark"
            :name="GIconName.Moon"
            :size="16"
            weight="bold"
          />
          <GIcon
            v-else
            :name="GIconName.Sun"
            :size="16"
            weight="bold"
          />
        </button>
        <UserMenu />
      </div>
      <div class="mobile-right">
        <button
          class="icon-btn"
          :aria-label="open ? 'Close menu' : 'Open menu'"
          @click="open = !open"
        >
          <GIcon
            v-if="open"
            :name="GIconName.X"
            :size="18"
            weight="bold"
          />
          <GIcon
            v-else
            :name="GIconName.Menu"
            :size="18"
            weight="bold"
          />
        </button>
        <button
          class="icon-btn"
          :aria-label="isDark ? 'Switch to light mode' : 'Switch to dark mode'"
          @click="toggle"
        >
          <GIcon
            v-if="!isDark"
            :name="GIconName.Moon"
            :size="16"
            weight="bold"
          />
          <GIcon
            v-else
            :name="GIconName.Sun"
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
import {
  ref,
} from 'vue';
import {
  storeToRefs,
} from 'pinia';
import {
  GIcon, GIconName,
  GKbdShortcut, GKbdKeyName,
} from '@hdnax/genuix';
import {
  useThemeStore,
} from '@/stores/theme';
import SiteLogo from '@/components/layout/SiteLogo.vue';
import UserMenu from '@/components/layout/UserMenu.vue';

const emit = defineEmits<{ (e: 'open-palette'): void }>();

const themeStore = useThemeStore();
const {
  isDark,
} = storeToRefs(themeStore);
const {
  toggle,
} = themeStore;
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
@reference "@/style.css";
.nav {
  @apply border-b;
  border-color: var(--gui-neutral-border);
  background-color: var(--gui-neutral-bg);
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
  @apply h-14 w-14;
  color: var(--gui-neutral-fg);
}
.logo-text {
  @apply text-sm font-bold;
}
.right {
  @apply hidden sm:flex items-center gap-4 ml-auto;
}
.nav-link {
  @apply text-xs no-underline;
  color: var(--gui-neutral-fg-muted);
  &:hover { color: var(--gui-neutral-fg); }
}
.icon-btn {
  @apply p-1 cursor-pointer;
  color: var(--gui-neutral-solid);
  &:hover { color: var(--gui-neutral-fg); }
}
.mobile-right {
  @apply sm:hidden flex items-center gap-1 ml-auto;
}
.mobile-menu {
  @apply sm:hidden border-t px-4 py-2 flex flex-col gap-1;
  border-color: var(--gui-neutral-border-subtle);
}
.mobile-link {
  @apply text-sm no-underline py-1;
  color: var(--gui-neutral-fg-muted);
  &:hover { color: var(--gui-neutral-fg); }
}
.tooltip-search {
  @apply flex items-center gap-2 text-xs;
  color: var(--gui-neutral-fg-muted);
}
</style>
