<template>
  <nav class="navbar border-b">
    <div class="navbar-inner flex items-center">
      <RouterLink
        to="/"
        class="no-underline flex items-center gap-0.5"
      >
        <SiteLogo class="navbar-logo h-14 w-14" />
        <span class="text-sm font-bold">scrambled</span>
      </RouterLink>
      <div class="hidden sm:flex items-center gap-4 ml-auto">
        <RouterLink
          v-for="link in navLinks"
          :key="link.to"
          :to="link.to"
          class="nav-link text-xs no-underline"
        >
          {{ link.label }}
        </RouterLink>
        <VTooltip placement="bottom">
          <button
            type="button"
            class="icon-btn p-1 cursor-pointer"
            aria-label="Open search"
            @click="openPalette"
          >
            <GIcon
              :name="GIconName.Search"
              :size="16"
              weight="bold"
            />
          </button>
          <template #popper>
            <span class="navbar-tooltip-hint flex items-center gap-2 text-xs">Search <GKbdShortcut
              :keys="[
                GKbdKeyName.Alt,
                GKbdKeyName.P,
              ]"
            /></span>
          </template>
        </VTooltip>
        <GThemeToggle :size="16" />
        <UserMenu />
      </div>
      <div class="sm:hidden flex items-center gap-1 ml-auto">
        <button
          type="button"
          class="icon-btn p-1 cursor-pointer"
          :aria-label="open ? 'Close menu' : 'Open menu'"
          @click="toggleMenu"
        >
          <GIcon
            v-if="open"
            key="g-icon-1"
            :name="GIconName.X"
            :size="18"
            weight="bold"
          />
          <GIcon
            v-else
            key="g-icon-2"
            :name="GIconName.Menu"
            :size="18"
            weight="bold"
          />
        </button>
        <GThemeToggle :size="16" />
        <UserMenu />
      </div>
    </div>
    <div
      v-if="open"
      class="navbar-mobile-menu sm:hidden border-t px-4 py-2 flex flex-col gap-1"
    >
      <RouterLink
        v-for="link in navLinks"
        :key="link.to"
        :to="link.to"
        class="mobile-link text-sm no-underline py-1"
        @click="closeMenu"
      >
        {{ link.label }}
      </RouterLink>
    </div>
  </nav>
</template>

<script setup lang="ts">
import {
  ref,
} from 'vue';
import {
  GIcon, GIconName,
  GKbdShortcut, GKbdKeyName,
  GThemeToggle,
} from '@hdnax/genuix';
import SiteLogo from '@/components/layout/SiteLogo.vue';
import UserMenu from '@/components/layout/UserMenu.vue';

const emit = defineEmits<{
  'open-palette': [];
}>();
const open = ref(false);

function closeMenu () {
  open.value = false;
}

function openPalette () {
  emit('open-palette');
}

function toggleMenu () {
  open.value = !open.value;
}

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
.navbar {
  border-color: var(--gui-neutral-border);
  background-color: var(--gui-neutral-bg);
}
.navbar-inner {
  max-width: 64rem;
  margin: 0 auto;
  padding: 0 1rem;
  height: 3rem;
}
.navbar-logo {
  color: var(--gui-neutral-fg);
}
.nav-link {
  color: var(--gui-neutral-fg-muted);
}
.icon-btn {
  color: var(--gui-neutral-solid);
}
.navbar-tooltip-hint {
  color: var(--gui-neutral-fg-muted);
}
.mobile-link {
  color: var(--gui-neutral-fg-muted);
}
.navbar-mobile-menu {
  border-color: var(--gui-neutral-border-subtle);
}
.nav-link:hover { color: var(--gui-neutral-fg); }
.icon-btn:hover { color: var(--gui-neutral-fg); }
.mobile-link:hover { color: var(--gui-neutral-fg); }
</style>
