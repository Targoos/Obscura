<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Iniciar Sesión — Obscura" });

const { signIn, loading, error } = useAuth();

async function onSubmit(payload: { email: string; password: string }) {
  try {
    await signIn(payload.email, payload.password);
    await navigateTo("/");
  } catch {
    // error reactivo expuesto por useAuth ya contiene el mensaje
  }
}
</script>

<template>
  <AuthLoginForm
    :loading="loading"
    :error="error ?? undefined"
    @submit="onSubmit"
  />
</template>
