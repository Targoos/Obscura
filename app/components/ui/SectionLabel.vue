<script setup lang="ts">
defineProps<{ label: string }>();
</script>

<template>
  <div class="section-label" role="heading" aria-level="2">{{ label }}</div>
</template>
