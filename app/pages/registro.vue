<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Crear Cuenta — Obscura" });

const { signUp, loading, error } = useAuth();

async function onSubmit(payload: {
  username: string;
  email: string;
  password: string;
  confirmPassword: string;
}) {
  try {
    await signUp(payload.email, payload.password, payload.username);
    await navigateTo("/login?registered=true");
  } catch {
    // error reactivo expuesto por useAuth ya contiene el mensaje
  }
}
</script>

<template>
  <AuthRegisterForm
    :loading="loading"
    :error="error ?? undefined"
    @submit="onSubmit"
  />
</template>
