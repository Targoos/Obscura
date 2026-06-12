<script setup lang="ts">
const props = defineProps<{
  src?: string | null;
  name?: string | null;
  size?: "sm" | "md" | "lg";
}>();

const initial = computed(() =>
  props.name ? props.name.charAt(0).toUpperCase() : "?",
);

const sizeClass = computed(
  () =>
    ({
      sm: "size-8 text-xs",
      md: "size-10 text-sm",
      lg: "size-14 text-lg",
    })[props.size ?? "md"],
);
</script>

<template>
  <div
    :class="[
      'rounded-full overflow-hidden bg-[--color-surface-2] flex items-center justify-center shrink-0',
      sizeClass,
    ]"
    :aria-label="name ?? 'Avatar'"
  >
    <NuxtImg
      v-if="src"
      :src="src"
      :alt="name ?? ''"
      class="w-full h-full object-cover"
    />
    <span v-else class="text-mono-data text-[--color-muted]">{{
      initial
    }}</span>
  </div>
</template>
