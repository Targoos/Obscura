<script setup lang="ts">
useHead({
  bodyAttrs: { style: "background: #080808; margin: 0; padding: 0;" },
});
</script>

<template>
  <div class="auth-layout">
    <slot />
  </div>
</template>

<style scoped>
.auth-layout {
  min-height: 100vh;
  background: #080808;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
