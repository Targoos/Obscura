<script setup lang="ts">
defineProps<{
  message?: string;
}>();

const emit = defineEmits<{
  retry: [];
}>();
</script>

<template>
  <div class="flex flex-col items-center justify-center py-16 text-center">
    <UIcon
      name="i-heroicons-exclamation-triangle"
      class="size-12 text-[--color-danger] mb-4"
    />
    <h3 class="text-mystery-title text-lg mb-2">Error al cargar</h3>
    <p class="text-[--color-muted] text-sm mb-6">
      {{ message ?? "Ha ocurrido un error inesperado." }}
    </p>
    <UButton variant="outline" color="error" @click="emit('retry')">
      Reintentar
    </UButton>
  </div>
</template>
