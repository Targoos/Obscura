<script setup lang="ts">
defineProps<{
  columns: { key: string; label: string }[];
  rows: Record<string, unknown>[];
  loading?: boolean;
  total?: number;
}>();

defineEmits<{
  sort: [key: string];
  page: [page: number];
}>();
</script>

<template>
  <div>
    <!-- TODO: sortable table with skeleton rows when loading -->
  </div>
</template>
