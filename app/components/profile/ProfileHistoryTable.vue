<script setup lang="ts">
export interface HistoryEntry {
  id: string
  title: string
  consultedAt: string
  category: 'paranormal' | 'desaparicion' | 'crimen' | 'conspiracion'
  categoryLabel: string
}

defineProps<{
  entries: HistoryEntry[]
}>()
</script>

<template>
  <div class="history-table">
    <div class="history-header">
      <span>ID CASO</span>
      <span>TÍTULO</span>
      <span class="col-optional">CONSULTADO</span>
      <span class="col-optional">CATEGORÍA</span>
    </div>
    <div
      v-for="entry in entries"
      :key="entry.id"
      class="history-row"
    >
      <div class="history-case-id">{{ entry.id }}</div>
      <div class="history-title">{{ entry.title }}</div>
      <div class="history-date col-optional">{{ entry.consultedAt }}</div>
      <div
        class="history-cat col-optional"
        :class="{
          'cat-paranormal': entry.category === 'paranormal',
          'cat-desaparicion': entry.category === 'desaparicion',
          'cat-crimen': entry.category === 'crimen',
          'cat-conspiracion': entry.category === 'conspiracion',
        }"
      >
        {{ entry.categoryLabel }}
      </div>
    </div>
  </div>
</template>

<style scoped>
/* CSS copied from obscura-perfil.html */

.history-table {
  border: 1px solid var(--color-border);
  border-radius: 4px;
  overflow: hidden;
}
.history-header {
  display: grid;
  grid-template-columns: 130px 1fr 140px 140px;
  gap: 0;
  padding: 10px 16px;
  background: var(--color-surface-2);
  border-bottom: 1px solid var(--color-border);
}
.history-header span {
  font-family: var(--font-mono);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
}
.history-row {
  display: grid;
  grid-template-columns: 130px 1fr 140px 140px;
  gap: 0;
  padding: 12px 16px;
  border-bottom: 1px solid var(--color-border);
  border-left: 2px solid transparent;
  transition: border-left-color 0.2s, background 0.15s;
  cursor: pointer;
  align-items: center;
}
.history-row:last-child {
  border-bottom: none;
}
.history-row:hover {
  border-left-color: var(--color-accent);
  background: rgba(204, 0, 0, 0.02);
}

.history-case-id {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--color-muted);
}
.history-title {
  font-family: var(--font-display);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--color-text);
  padding-right: 16px;
}
.history-date {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.14em;
  color: var(--color-muted);
}
.history-cat {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 3px 8px;
  border-radius: 4px;
  white-space: nowrap;
  width: fit-content;
}

.cat-paranormal {
  color: #9b59b6;
  border: 1px solid rgba(155, 89, 182, 0.4);
  background: rgba(155, 89, 182, 0.04);
}
.cat-desaparicion {
  color: var(--color-classified);
  border: 1px solid rgba(255, 102, 0, 0.4);
  background: rgba(255, 102, 0, 0.04);
}
.cat-crimen {
  color: var(--color-accent);
  border: 1px solid rgba(204, 0, 0, 0.4);
  background: rgba(204, 0, 0, 0.04);
}
.cat-conspiracion {
  color: var(--color-warning);
  border: 1px solid rgba(184, 134, 11, 0.4);
  background: rgba(184, 134, 11, 0.04);
}

/* MOBILE: hide CONSULTADO and CATEGORÍA */
@media (max-width: 768px) {
  .history-header {
    display: none;
  }
  .history-row {
    grid-template-columns: 100px 1fr;
  }
  .col-optional {
    display: none;
  }
}
</style>
