<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

defineProps<{
  mysteries: Mystery[];
}>();

// Leaflet loaded client-side only — ssr: false on /mapa page
</script>

<template>
  <div class="w-full h-full" aria-label="Mapa mundial de casos">
    <!-- TODO: LMap + LTileLayer dark theme + LMarkerClusterGroup -->
  </div>
</template>
