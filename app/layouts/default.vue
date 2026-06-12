<script setup lang="ts"></script>

<template>
  <div class="layout-root">
    <AppHeader />
    <main class="flex-1">
      <slot />
    </main>
    <AppFooter />
  </div>
</template>

<style>
/* Explicit background so @nuxt/ui color-mode can never override the dark base */
.layout-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--color-bg, #080808);
}
</style>
