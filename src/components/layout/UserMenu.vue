<template>
  <template v-if="isLoggedIn">
    <Dropdown :distance="6">
      <img
        v-if="avatarUrl"
        :src="avatarUrl"
        class="user-avatar w-5 h-5 rounded-full cursor-pointer border"
        :title="displayName"
      >
      <span
        v-else
        class="user-avatar-fallback w-5 h-5 rounded-full text-xs flex items-center justify-center cursor-pointer border"
      >{{ displayName[0] }}</span>
      <template #popper>
        <div class="user-menu-dropdown flex flex-col min-w-36">
          <div class="px-3 py-2">
            <span class="user-menu-name text-xs font-medium">{{ displayName }}</span>
          </div>
          <button
            type="button"
            class="menu-btn text-left text-xs px-3 py-2 cursor-pointer transition-colors"
            @click="signOut"
          >
            Sign out
          </button>
        </div>
      </template>
    </Dropdown>
  </template>
  <button
    v-else-if="!loading"
    type="button"
    class="signin-btn flex items-center gap-1 text-xs px-2.5 py-1 rounded-sm hover:opacity-80 transition-opacity cursor-pointer"
    aria-label="Sign in with GitHub"
    @click="signInWithGithub"
  >
    <GIcon
      :name="GIconName.GithubLogo"
      :size="14"
    />
    <span class="hidden sm:inline">Sign in</span>
  </button>
</template>

<script setup lang="ts">
import {
  GIcon, GIconName,
} from '@hdnax/genuix';
import {
  Dropdown,
} from 'floating-vue';
import {
  useAuth,
} from '@/composables/useSupabase';

const {
  loading, isLoggedIn, displayName, avatarUrl, signInWithGithub, signOut,
} = useAuth();
</script>

<style scoped>
.user-avatar {
  border-color: var(--gui-neutral-fg);
}
.user-avatar-fallback {
  background-color: var(--gui-neutral-bg-subtle);
  color: var(--gui-neutral-solid);
  border-color: var(--gui-neutral-fg);
}
.user-menu-dropdown {
  background-color: var(--gui-neutral-bg);
  color: var(--gui-neutral-fg);
}
.user-menu-name {
  color: var(--gui-neutral-fg);
}
.menu-btn {
  color: var(--gui-neutral-fg-muted);
}
.signin-btn {
  background-color: var(--gui-neutral-fg);
  color: var(--gui-neutral-bg);
}
.menu-btn:hover { background-color: var(--gui-neutral-bg-subtle); }
</style>
