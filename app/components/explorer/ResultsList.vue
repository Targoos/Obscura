<script setup lang="ts">
import type { Mystery } from "~/types/mystery";
import type { BadgeVariant } from "~/components/ui/StatusBadge.vue";

defineProps<{
  cases: Mystery[];
  view: "grid" | "list";
}>();

function getBadgeVariant(m: Mystery): BadgeVariant {
  if (m.status === "archived") return "archivado";
  switch (m.classification_level) {
    case "classified":
      return "clasificado";
    case "extreme":
      return "extremo";
    case "disturbing":
      return "perturbador";
    default:
      return "abierto";
  }
}

function getDotClass(m: Mystery): string {
  return `dot--${getBadgeVariant(m)}`;
}
</script>

<template>
  <!-- Grid -->
  <div
    v-if="view === 'grid'"
    class="results-grid"
    aria-label="Resultados en cuadrícula"
  >
    <MysteryCard
      v-for="(m, i) in cases"
      :key="m.id"
      :mystery="m"
      class="slide-up"
      :style="{ animationDelay: `${0.05 + i * 0.05}s` }"
    />
  </div>

  <!-- List -->
  <div v-else class="results-list" aria-label="Resultados en lista">
    <NuxtLink
      v-for="m in cases"
      :key="m.id"
      :to="`/caso/${m.slug}`"
      class="list-row"
      :aria-label="`${m.id} — ${m.title}`"
    >
      <span :class="['list-dot', getDotClass(m)]" aria-hidden="true" />
      <span class="list-case-id">{{ m.id }}</span>
      <span class="list-title">{{ m.title }}</span>
      <span class="list-country">{{ m.country?.code ?? "—" }}</span>
      <span class="list-year">{{ m.year_occurred ?? "—" }}</span>
      <span v-if="m.category" class="list-category">{{ m.category.name }}</span>
      <StatusBadge :variant="getBadgeVariant(m)" class="list-status" />
    </NuxtLink>
  </div>
</template>

<style scoped>
/* Grid */
.results-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.slide-up {
  opacity: 0;
  transform: translateY(20px);
  animation: slideUp 0.45s ease forwards;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* List */
.results-list {
  display: flex;
  flex-direction: column;
  border: 1px solid var(--color-border);
}

.list-row {
  display: flex;
  align-items: center;
  height: 52px;
  padding: 0 16px;
  gap: 16px;
  border-bottom: 1px solid var(--color-border);
  cursor: pointer;
  position: relative;
  text-decoration: none;
  color: inherit;
  transition: background 0.15s;
}

.list-row:last-child {
  border-bottom: none;
}

.list-row::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: transparent;
  transition: background 0.15s;
}

.list-row:hover {
  background: var(--color-surface-2);
}

.list-row:hover::before {
  background: var(--color-accent);
}

.list-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  flex-shrink: 0;
}

.dot--abierto {
  background: var(--color-open);
}
.dot--archivado {
  background: var(--color-muted);
}
.dot--clasificado {
  background: var(--color-classified);
}
.dot--extremo {
  background: var(--color-danger);
}
.dot--perturbador {
  background: var(--color-warning);
}
.dot--sin-resolver {
  background: var(--color-accent);
}

.list-case-id {
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.15em;
  color: var(--color-muted);
  text-transform: uppercase;
  width: 120px;
  flex-shrink: 0;
  white-space: nowrap;
}

.list-title {
  font-family: var(--font-display);
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text);
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.list-country {
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.12em;
  color: var(--color-muted);
  flex-shrink: 0;
  width: 36px;
  text-align: center;
}

.list-year {
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.12em;
  color: var(--color-muted);
  width: 52px;
  flex-shrink: 0;
  text-align: right;
}

.list-category {
  font-family: var(--font-mono);
  font-size: 8.5px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--color-muted);
  border: 1px solid var(--color-border);
  padding: 2px 7px;
  white-space: nowrap;
  flex-shrink: 0;
}

.list-status {
  flex-shrink: 0;
}

@media (max-width: 768px) {
  .results-grid {
    grid-template-columns: 1fr;
  }

  .list-status {
    display: none;
  }

  .list-case-id {
    width: 80px;
    font-size: 8.5px;
  }
}
</style>
