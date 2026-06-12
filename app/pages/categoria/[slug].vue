<script setup lang="ts">
const route = useRoute();
const _slug = computed(() => route.params.slug as string);
</script>

<template>
  <div>
    <!-- TODO: category header + MysteryGrid filtered by category -->
  </div>
</template>
