<script setup lang="ts">
defineProps<{
  title: string;
  description?: string;
  icon?: string;
}>();
</script>

<template>
  <div class="flex flex-col items-center justify-center py-16 text-center">
    <UIcon
      v-if="$props.icon"
      :name="$props.icon"
      class="size-12 text-[--color-muted] mb-4"
    />
    <h3 class="text-mystery-title text-lg mb-2">{{ title }}</h3>
    <p v-if="description" class="text-[--color-muted] text-sm max-w-sm">
      {{ description }}
    </p>
    <slot />
  </div>
</template>
