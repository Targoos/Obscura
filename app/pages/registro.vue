<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Crear Cuenta — Obscura" });

const loading = ref(false);
const error = ref<string | undefined>();

async function onSubmit(_payload: {
  username: string;
  email: string;
  password: string;
  confirmPassword: string;
}) {
  loading.value = true;
  error.value = undefined;
  try {
    // TODO: useAuth().signUp(payload)
    await new Promise((r) => setTimeout(r, 800));
  } catch {
    error.value = "ERROR AL CREAR CREDENCIALES — INTENTALO DE NUEVO";
  } finally {
    loading.value = false;
  }
}
</script>

<template>
  <AuthRegisterForm :loading="loading" :error="error" @submit="onSubmit" />
</template>
