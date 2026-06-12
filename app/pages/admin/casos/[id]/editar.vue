<script setup lang="ts">
definePageMeta({ middleware: ["auth", "admin"], layout: "admin" });

const route = useRoute();
const _id = computed(() => route.params.id as string);

useHead({ title: "Editar Caso — Obscura Admin" });
</script>

<template>
  <div>
    <!-- TODO: pre-filled mystery edit form -->
  </div>
</template>
