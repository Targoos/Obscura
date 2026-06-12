<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Iniciar Sesión — Obscura" });
</script>

<template>
  <AuthLoginForm />
</template>
