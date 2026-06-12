<script setup lang="ts">
const props = defineProps<{
  error: {
    statusCode: number;
    statusMessage: string;
    message: string;
  };
}>();

function handleError() {
  clearError({ redirect: "/" });
}
</script>

<template>
  <div
    class="min-h-screen flex flex-col items-center justify-center text-center px-4"
  >
    <p class="text-mono-data text-[--color-accent] mb-2">
      ARCHIVO :: {{ props.error.statusCode }}
    </p>
    <h1 class="text-mystery-title text-4xl mb-4">
      {{
        props.error.statusCode === 404 ? "Caso No Encontrado" : "Error Interno"
      }}
    </h1>
    <p class="text-[--color-muted] mb-8 max-w-md">
      {{
        props.error.statusCode === 404
          ? "Este archivo no existe o ha sido clasificado."
          : props.error.statusMessage
      }}
    </p>
    <UButton color="error" variant="outline" @click="handleError">
      Volver al inicio
    </UButton>
  </div>
</template>
