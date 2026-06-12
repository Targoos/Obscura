<script setup lang="ts">
defineProps<{
  items: { label: string; to?: string }[];
}>();
</script>

<template>
  <nav aria-label="Ruta de navegación">
    <ol
      class="flex items-center gap-2 text-xs text-mono-data text-[--color-muted]"
      role="list"
    >
      <li v-for="(item, i) in items" :key="i" class="flex items-center gap-2">
        <NuxtLink
          v-if="item.to"
          :to="item.to"
          class="hover:text-[--color-text] transition-colors"
        >
          {{ item.label }}
        </NuxtLink>
        <span v-else aria-current="page" class="text-[--color-text]">{{
          item.label
        }}</span>
        <span v-if="i < items.length - 1" aria-hidden="true">/</span>
      </li>
    </ol>
  </nav>
</template>
