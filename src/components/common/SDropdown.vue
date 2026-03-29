<template>
  <VDropdown
    :distance="4"
    placement="bottom-start"
  >
    <slot name="trigger" />
    <template #popper="{ hide }">
      <div class="menu">
        <slot :hide="hide" />
      </div>
    </template>
  </VDropdown>
</template>

<script setup lang="ts">
import { Dropdown as VDropdown } from 'floating-vue';
</script>

<style scoped>
@reference "../../style.css";
.menu {
  @apply flex flex-col;
  min-width: 120px;
}
</style>

<style>
.v-popper--theme-dropdown .v-popper__inner {
  background: var(--color-bg) !important;
  color: var(--color-fg) !important;
  border: 1px solid var(--color-border) !important;
  border-radius: 6px !important;
  box-shadow: 0 2px 8px color-mix(in oklch, var(--color-fg) 6%, transparent) !important;
  padding: 4px 0 !important;
  overflow: hidden;
}
.v-popper--theme-dropdown .v-popper__arrow-outer {
  border-color: var(--color-border) !important;
}
.v-popper--theme-dropdown .v-popper__arrow-inner {
  border-color: var(--color-bg) !important;
}
</style>
