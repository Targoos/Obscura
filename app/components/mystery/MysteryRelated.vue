<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

defineProps<{ mysteries: Mystery[] }>();

function statusColor(m: Mystery): string {
  if (m.classification_level === "classified") return "var(--color-classified)";
  if (m.status === "archived") return "var(--color-muted)";
  if (m.status === "published") return "var(--color-open)";
  return "var(--color-warning)";
}

function statusLabel(m: Mystery): string {
  if (m.classification_level === "classified") return "Clasificado";
  if (m.status === "archived") return "Archivado";
  if (m.status === "published") return "Abierto";
  return "Sin resolver";
}

function bgIndex(m: Mystery): number {
  const hash = Array.from(m.id).reduce((acc, c) => acc + c.charCodeAt(0), 0);
  return (hash % 10) + 1;
}
</script>

<template>
  <div class="related-card" aria-label="Casos relacionados">
    <div class="related-header">// CASOS RELACIONADOS</div>
    <NuxtLink
      v-for="mystery in mysteries"
      :key="mystery.id"
      :to="`/caso/${mystery.slug}`"
      class="related-item"
      :aria-label="`Caso: ${mystery.title}`"
    >
      <div
        :class="['related-thumb', `card-bg--${bgIndex(mystery)}`]"
        aria-hidden="true"
      />
      <div class="related-info">
        <div class="related-title-row">
          <span
            class="related-status-dot"
            :style="{ background: statusColor(mystery) }"
            :aria-label="statusLabel(mystery)"
          />
          <span class="related-name">{{ mystery.title }}</span>
        </div>
        <div class="related-meta-row">
          <span>{{ mystery.year_occurred ?? "—" }}</span>
          <span aria-hidden="true">·</span>
          <span v-if="mystery.country">
            <span aria-hidden="true">{{ mystery.country.flag_emoji }}</span>
            {{ mystery.country.name }}
          </span>
        </div>
      </div>
    </NuxtLink>
  </div>
</template>

<style scoped>
.related-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.related-header {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
  padding: 12px 14px;
  border-bottom: 1px solid var(--color-border);
}

.related-item {
  display: flex;
  gap: 12px;
  align-items: flex-start;
  padding: 12px 14px;
  border-bottom: 1px solid rgba(31, 31, 31, 0.7);
  text-decoration: none;
  transition: background 0.2s;
}

.related-item:last-child {
  border-bottom: none;
}

.related-item:hover {
  background: rgba(255, 255, 255, 0.02);
}

.related-thumb {
  width: 50px;
  height: 50px;
  border-radius: var(--radius-sm);
  flex-shrink: 0;
  border: 1px solid var(--color-border);
  overflow: hidden;
  filter: grayscale(0.75) brightness(0.45) contrast(1.1);
}

.related-info {
  min-width: 0;
  flex: 1;
}

.related-title-row {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-bottom: 5px;
}

.related-status-dot {
  width: 5px;
  height: 5px;
  border-radius: 50%;
  flex-shrink: 0;
}

.related-name {
  font-family: var(--font-display);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--color-text);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.related-meta-row {
  font-family: var(--font-mono);
  font-size: 9.5px;
  color: var(--color-muted);
  letter-spacing: 0.1em;
  display: flex;
  gap: 6px;
}
</style>
