<script setup lang="ts">
const links = [
  { label: "Explorar", to: "/explorar" },
  { label: "Mapa", to: "/mapa" },
  { label: "Cronología", to: "/cronologia" },
];
</script>

<template>
  <ul class="flex items-center gap-6 list-none" role="list">
    <li v-for="link in links" :key="link.to">
      <NuxtLink
        :to="link.to"
        class="text-sm text-[--color-muted] hover:text-[--color-text] transition-colors"
        active-class="text-[--color-text]"
      >
        {{ link.label }}
      </NuxtLink>
    </li>
  </ul>
</template>
