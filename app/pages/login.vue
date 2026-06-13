<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Iniciar Sesión — Obscura" });

const loading = ref(false);
const error = ref<string | undefined>();

async function onSubmit(_payload: { email: string; password: string }) {
  loading.value = true;
  error.value = undefined;
  try {
    // TODO: useAuth().signIn(payload)
    await new Promise((r) => setTimeout(r, 800));
  } catch {
    error.value = "ACCESO DENEGADO — CREDENCIALES INVÁLIDAS";
  } finally {
    loading.value = false;
  }
}
</script>

<template>
  <AuthLoginForm :loading="loading" :error="error" @submit="onSubmit" />
</template>
