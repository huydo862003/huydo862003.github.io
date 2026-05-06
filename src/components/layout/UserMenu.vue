<template>
  <template v-if="isLoggedIn">
    <Dropdown :distance="6">
      <img
        v-if="avatarUrl"
        :src="avatarUrl"
        class="avatar"
        :title="displayName"
      >
      <span
        v-else
        class="avatar-fallback"
      >{{ displayName[0] }}</span>
      <template #popper>
        <div class="user-menu">
          <div class="user-info">
            <span class="user-name">{{ displayName }}</span>
          </div>
          <button
            class="menu-btn"
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
    class="sign-in-btn"
    aria-label="Sign in with GitHub"
    @click="signInWithGithub"
  >
    <GIcon
      :name="GIconName.GithubLogo"
      :size="14"
    />
    <span class="sign-in-text">Sign in</span>
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
@reference "@/style.css";
.avatar {
  @apply w-5 h-5 rounded-full cursor-pointer border;
  border-color: var(--gui-neutral-fg);
}
.avatar-fallback {
  @apply w-5 h-5 rounded-full text-xs flex items-center justify-center cursor-pointer border;
  background-color: var(--gui-neutral-bg-subtle);
  color: var(--gui-neutral-solid);
  border-color: var(--gui-neutral-fg);
}
.sign-in-btn {
  @apply flex items-center gap-1 text-xs px-2.5 py-1 rounded-sm
         hover:opacity-80 transition-opacity cursor-pointer;
  background-color: var(--gui-neutral-fg);
  color: var(--gui-neutral-bg);
}
.sign-in-text {
  @apply hidden sm:inline;
}
.user-menu {
  @apply flex flex-col min-w-36;
  background-color: var(--gui-neutral-bg);
  color: var(--gui-neutral-fg);
}
.user-info {
  @apply px-3 py-2;
}
.user-name {
  @apply text-xs font-medium;
  color: var(--gui-neutral-fg);
}
.menu-btn {
  @apply text-left text-xs px-3 py-2 cursor-pointer transition-colors;
  color: var(--gui-neutral-fg-muted);
  &:hover { background-color: var(--gui-neutral-bg-subtle); }
}
</style>
