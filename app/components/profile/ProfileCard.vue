<script setup lang="ts">
defineProps<{
  id: string
  title: string
  year: number
  country: string
  category: string
  status: 'clasificado' | 'sin-resolver' | 'archivado'
  imageClass: string
}>()
</script>

<template>
  <div class="mystery-card">
    <div class="card-image" :class="imageClass">
      <div
        class="card-badge"
        :class="{
          'badge-clasificado': status === 'clasificado',
          'badge-sin-resolver': status === 'sin-resolver',
          'badge-archivado': status === 'archivado',
        }"
      >
        {{ status === 'clasificado' ? 'CLASIFICADO' : status === 'sin-resolver' ? 'SIN RESOLVER' : 'ARCHIVADO' }}
      </div>
    </div>
    <div class="card-body">
      <div class="card-id">{{ id }}</div>
      <div class="card-title">{{ title }}</div>
      <div class="card-meta">{{ country }} · {{ year }} · {{ category }}</div>
    </div>
    <div class="card-bottom-border" />
  </div>
</template>

<style scoped>
/* CSS copied from obscura-perfil.html */

.mystery-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 4px;
  overflow: hidden;
  cursor: pointer;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.mystery-card:hover {
  border-color: var(--color-accent);
  box-shadow: 0 4px 24px rgba(204, 0, 0, 0.08);
}

.card-image {
  height: 180px;
  position: relative;
  overflow: hidden;
}
.card-image::after {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, transparent 40%, rgba(8, 8, 8, 0.85) 100%);
}

.card-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 2;
  font-family: var(--font-mono);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 4px 8px;
  border-radius: 4px;
}
.badge-sin-resolver {
  color: var(--color-warning);
  border: 1px solid var(--color-warning);
  background: rgba(184, 134, 11, 0.06);
}
.badge-clasificado {
  color: var(--color-classified);
  border: 1px solid var(--color-classified);
  background: rgba(255, 102, 0, 0.06);
}
.badge-archivado {
  color: var(--color-muted);
  border: 1px solid var(--color-border);
  background: rgba(68, 68, 68, 0.06);
}

.card-body {
  padding: 16px;
}
.card-id {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-muted);
  margin-bottom: 6px;
}
.card-title {
  font-family: var(--font-display);
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--color-text);
  margin-bottom: 10px;
  line-height: 1.3;
}
.card-meta {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.14em;
  color: var(--color-muted);
}

.card-bottom-border {
  height: 2px;
  background: transparent;
  transition: background 0.2s;
}
.mystery-card:hover .card-bottom-border {
  background: var(--color-accent);
}
</style>
