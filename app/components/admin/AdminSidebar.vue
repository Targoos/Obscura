<script setup lang="ts">
const navItems = [
  { label: "Dashboard", to: "/admin", icon: "i-heroicons-squares-2x2" },
  { label: "Casos", to: "/admin/casos", icon: "i-heroicons-document-text" },
  { label: "Usuarios", to: "/admin/usuarios", icon: "i-heroicons-users" },
  { label: "Categorías", to: "/admin/categorias", icon: "i-heroicons-tag" },
  { label: "Países", to: "/admin/paises", icon: "i-heroicons-globe-alt" },
  { label: "Etiquetas", to: "/admin/etiquetas", icon: "i-heroicons-hashtag" },
  {
    label: "Comentarios",
    to: "/admin/comentarios",
    icon: "i-heroicons-chat-bubble-left",
  },
  {
    label: "Destacados",
    to: "/admin/contenido-destacado",
    icon: "i-heroicons-star",
  },
  {
    label: "Estadísticas",
    to: "/admin/estadisticas",
    icon: "i-heroicons-chart-bar",
  },
];
</script>

<template>
  <aside
    aria-label="Panel de administración"
    class="w-60 border-r border-[--color-border] flex flex-col shrink-0"
  >
    <div class="p-4 border-b border-[--color-border]">
      <NuxtLink to="/" class="text-mystery-title text-sm">OBSCURA</NuxtLink>
      <p class="text-mono-data text-[--color-muted] text-xs mt-1">
        PANEL ADMIN
      </p>
    </div>
    <nav class="flex-1 p-2 overflow-y-auto">
      <ul class="space-y-1" role="list">
        <li v-for="item in navItems" :key="item.to">
          <NuxtLink
            :to="item.to"
            class="flex items-center gap-3 px-3 py-2 rounded-[--radius-sm] text-sm text-[--color-muted] hover:text-[--color-text] hover:bg-[--color-surface-2] transition-colors"
            active-class="text-[--color-text] bg-[--color-surface-2]"
          >
            <UIcon :name="item.icon" class="size-4 shrink-0" />
            {{ item.label }}
          </NuxtLink>
        </li>
      </ul>
    </nav>
  </aside>
</template>
