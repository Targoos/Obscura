<script setup lang="ts">
const props = defineProps<{
  open: boolean;
  title: string;
  description?: string;
  confirmLabel?: string;
  loading?: boolean;
}>();

const emit = defineEmits<{
  "update:open": [value: boolean];
  confirm: [];
}>();
</script>

<template>
  <UModal :open="props.open" @update:open="emit('update:open', $event)">
    <template #header>
      <h2 class="text-mystery-title">{{ props.title }}</h2>
    </template>
    <p v-if="props.description" class="text-[--color-muted] text-sm">
      {{ props.description }}
    </p>
    <template #footer>
      <div class="flex justify-end gap-3">
        <UButton variant="ghost" @click="emit('update:open', false)"
          >Cancelar</UButton
        >
        <UButton
          color="error"
          :loading="props.loading"
          @click="emit('confirm')"
        >
          {{ props.confirmLabel ?? "Confirmar" }}
        </UButton>
      </div>
    </template>
  </UModal>
</template>
