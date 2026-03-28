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
    @click="signInWithGithub"
  >
    <PhGithubLogo :size="14" />
    <span class="sign-in-text">Sign in</span>
  </button>
</template>

<script setup lang="ts">
import { PhGithubLogo } from '@phosphor-icons/vue';
import { Dropdown } from 'floating-vue';
import { useAuth } from '@/composables/use_supabase';

const {
  loading, isLoggedIn, displayName, avatarUrl, signInWithGithub, signOut,
} = useAuth();
</script>

<style scoped>
@reference "../style.css";
.avatar {
  @apply w-5 h-5 rounded-full cursor-pointer border border-fg;
}
.avatar-fallback {
  @apply w-5 h-5 rounded-full bg-bg-subtle text-fg-faint text-xs
         flex items-center justify-center cursor-pointer border border-fg;
}
.sign-in-btn {
  @apply flex items-center gap-1 text-xs px-2.5 py-1 rounded-sm
         bg-fg text-bg hover:opacity-80 transition-opacity cursor-pointer;
}
.sign-in-text {
  @apply hidden sm:inline;
}
.user-menu {
  @apply flex flex-col min-w-36 bg-bg text-fg;
}
.user-info {
  @apply px-3 py-2;
}
.user-name {
  @apply text-xs font-medium text-fg;
}
.menu-btn {
  @apply text-left text-xs text-fg-muted px-3 py-2 cursor-pointer
         hover:bg-bg-subtle transition-colors;
}
</style>
