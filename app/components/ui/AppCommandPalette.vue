<script setup lang="ts">
const open = ref(false);

defineShortcuts({
  meta_k: () => {
    open.value = !open.value;
  },
});
</script>

<template>
  <UModal v-model:open="open" class="max-w-xl">
    <!-- TODO: search input + results list -->
  </UModal>
</template>
