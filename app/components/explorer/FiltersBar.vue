<script setup lang="ts">
import type { ActiveFilter } from "~/components/explorer/ActiveFilterTags.vue";

const props = defineProps<{
  search: string;
  category: string;
  country: string;
  estado: string;
  clasificacion: string;
  view: "grid" | "list";
}>();

const emit = defineEmits<{
  "update:search": [value: string];
  "update:category": [value: string];
  "update:country": [value: string];
  "update:estado": [value: string];
  "update:clasificacion": [value: string];
  "update:view": [value: "grid" | "list"];
}>();

const CATEGORIES = [
  { value: "PARANORMAL" },
  { value: "CRIMEN" },
  { value: "DESAPARICIÓN" },
  { value: "OCULTISMO" },
  { value: "FENÓMENO" },
  { value: "CONSPIRACIÓN" },
];

const COUNTRIES = [
  { value: "ESPAÑA" },
  { value: "RUSIA" },
  { value: "EEUU" },
  { value: "MEXICO" },
  { value: "ALEMANIA" },
  { value: "JAPÓN" },
  { value: "ARGENTINA" },
];

const ESTADOS = [
  { value: "CASO ABIERTO" },
  { value: "ARCHIVADO" },
  { value: "SIN RESOLVER" },
  { value: "CLASIFICADO" },
];

const CLASIFICACIONES = [
  { value: "BAJO" },
  { value: "MEDIO" },
  { value: "ALTO" },
  { value: "EXTREMO" },
];

const activeFilters = computed<ActiveFilter[]>(() => {
  const tags: ActiveFilter[] = [];
  if (props.category)
    tags.push({ key: "category", label: "CATEGORÍA", value: props.category });
  if (props.country)
    tags.push({ key: "country", label: "PAÍS", value: props.country });
  if (props.estado)
    tags.push({ key: "estado", label: "ESTADO", value: props.estado });
  if (props.clasificacion)
    tags.push({
      key: "clasificacion",
      label: "CLASIFICACIÓN",
      value: props.clasificacion,
    });
  return tags;
});

function removeFilter(f: ActiveFilter) {
  if (f.key === "category") emit("update:category", "");
  else if (f.key === "country") emit("update:country", "");
  else if (f.key === "estado") emit("update:estado", "");
  else if (f.key === "clasificacion") emit("update:clasificacion", "");
}
</script>

<template>
  <div class="filters-bar" role="search">
    <div class="filters-bar-main">
      <div class="search-wrap">
        <input
          type="text"
          class="search-input"
          :value="search"
          placeholder="// buscar en el archivo..."
          autocomplete="off"
          spellcheck="false"
          aria-label="Buscar en el archivo"
          @input="
            emit('update:search', ($event.target as HTMLInputElement).value)
          "
        />
        <span class="search-prompt" aria-hidden="true">_</span>
      </div>

      <div class="filter-buttons" role="toolbar" aria-label="Filtros">
        <FilterDropdown
          label="CATEGORÍA"
          :options="CATEGORIES"
          :model-value="category"
          @update:model-value="emit('update:category', $event)"
        />
        <FilterDropdown
          label="PAÍS"
          :options="COUNTRIES"
          :model-value="country"
          @update:model-value="emit('update:country', $event)"
        />
        <FilterDropdown
          label="ESTADO"
          :options="ESTADOS"
          :model-value="estado"
          @update:model-value="emit('update:estado', $event)"
        />
        <FilterDropdown
          label="CLASIFICACIÓN"
          :options="CLASIFICACIONES"
          :model-value="clasificacion"
          @update:model-value="emit('update:clasificacion', $event)"
        />
      </div>

      <div class="view-toggle" aria-label="Cambiar vista">
        <button
          class="view-btn"
          :class="{ active: view === 'grid' }"
          :aria-pressed="view === 'grid'"
          aria-label="Vista en cuadrícula"
          @click="emit('update:view', 'grid')"
        >
          <svg viewBox="0 0 14 14" fill="currentColor" aria-hidden="true">
            <rect x="0" y="0" width="6" height="6" />
            <rect x="8" y="0" width="6" height="6" />
            <rect x="0" y="8" width="6" height="6" />
            <rect x="8" y="8" width="6" height="6" />
          </svg>
        </button>
        <button
          class="view-btn"
          :class="{ active: view === 'list' }"
          :aria-pressed="view === 'list'"
          aria-label="Vista en lista"
          @click="emit('update:view', 'list')"
        >
          <svg viewBox="0 0 14 14" fill="currentColor" aria-hidden="true">
            <rect x="0" y="1" width="14" height="2" />
            <rect x="0" y="6" width="14" height="2" />
            <rect x="0" y="11" width="14" height="2" />
          </svg>
        </button>
      </div>
    </div>

    <ActiveFilterTags :filters="activeFilters" @remove="removeFilter" />
  </div>
</template>

<style scoped>
.filters-bar {
  position: sticky;
  top: 64px;
  z-index: 100;
  background: var(--color-surface-2);
  border-bottom: 1px solid var(--color-border);
}

.filters-bar-main {
  display: flex;
  align-items: center;
  height: 56px;
  padding: 0 48px;
  gap: 16px;
}

.search-wrap {
  position: relative;
  display: flex;
  align-items: center;
  flex-shrink: 0;
}

.search-prompt {
  position: absolute;
  left: 10px;
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--color-accent);
  pointer-events: none;
  z-index: 1;
  animation: blink 1.1s step-end infinite;
}

.search-wrap:focus-within .search-prompt {
  display: none;
}

.search-input {
  width: 320px;
  height: 36px;
  background: var(--color-bg);
  border: 1px solid var(--color-border);
  border-radius: 0;
  color: var(--color-text);
  font-family: var(--font-mono);
  font-size: 11.5px;
  letter-spacing: 0.04em;
  padding: 0 12px 0 24px;
  outline: none;
  caret-color: var(--color-accent);
  transition:
    border-color 0.2s,
    box-shadow 0.2s;
}

.search-input::placeholder {
  color: var(--color-muted);
}

.search-input:focus {
  border-color: var(--color-accent);
  box-shadow: 0 0 0 2px rgba(204, 0, 0, 0.08);
}

.filter-buttons {
  display: flex;
  align-items: center;
  gap: 8px;
}

.view-toggle {
  display: flex;
  align-items: center;
  gap: 4px;
  margin-left: auto;
}

.view-btn {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: 0;
  color: var(--color-muted);
  cursor: pointer;
  transition:
    color 0.2s,
    border-color 0.2s;
}

.view-btn:hover {
  color: var(--color-text);
  border-color: var(--color-muted);
}

.view-btn.active {
  color: var(--color-accent);
  border-color: var(--color-accent-dim);
}

.view-btn svg {
  width: 14px;
  height: 14px;
}

@keyframes blink {
  0%,
  49% {
    opacity: 1;
  }
  50%,
  100% {
    opacity: 0;
  }
}

@media (max-width: 768px) {
  .filters-bar-main {
    padding: 10px 20px;
    height: auto;
    min-height: 56px;
    flex-wrap: wrap;
    gap: 10px;
  }

  .search-wrap {
    width: 100%;
    order: 0;
  }

  .search-input {
    width: 100%;
  }

  .filter-buttons {
    order: 1;
    width: 100%;
    overflow-x: auto;
    flex-wrap: nowrap;
    scrollbar-width: none;
    padding-bottom: 4px;
  }

  .filter-buttons::-webkit-scrollbar {
    display: none;
  }

  .view-toggle {
    order: 2;
    margin-left: auto;
  }
}
</style>
