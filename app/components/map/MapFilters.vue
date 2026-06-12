<script setup lang="ts">
const _emit = defineEmits<{
  change: [filters: { category?: string; country?: string }];
}>();
</script>

<template>
  <aside aria-label="Filtros del mapa">
    <!-- TODO: category and country filter selects -->
  </aside>
</template>
