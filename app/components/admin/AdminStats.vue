<script setup lang="ts">
defineProps<{
  stats: {
    label: string;
    value: number | string;
    icon?: string;
  }[];
}>();
</script>

<template>
  <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
    <div v-for="stat in stats" :key="stat.label" class="card-surface p-4">
      <!-- TODO: icon, value, label -->
    </div>
  </div>
</template>
