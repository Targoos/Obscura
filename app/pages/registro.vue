<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Crear Cuenta — Obscura" });
</script>

<template>
  <AuthRegisterForm />
</template>
