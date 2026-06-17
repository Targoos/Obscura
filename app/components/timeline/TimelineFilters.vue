<script setup lang="ts">
const props = defineProps<{
  sortAsc: boolean;
  filterFrom: number;
  filterTo: number;
  minYear: number;
  maxYear: number;
}>();

const emit = defineEmits<{
  "update:sortAsc": [value: boolean];
  "update:filterFrom": [value: number];
  "update:filterTo": [value: number];
  jump: [century: string];
}>();

const localFrom = ref(props.filterFrom);
const localTo = ref(props.filterTo);

watch(
  () => props.filterFrom,
  (v) => (localFrom.value = v),
);
watch(
  () => props.filterTo,
  (v) => (localTo.value = v),
);

function onFromInput(e: Event) {
  let val = parseInt((e.target as HTMLInputElement).value, 10);
  if (val > localTo.value) val = localTo.value;
  localFrom.value = val;
  emit("update:filterFrom", val);
}

function onToInput(e: Event) {
  let val = parseInt((e.target as HTMLInputElement).value, 10);
  if (val < localFrom.value) val = localFrom.value;
  localTo.value = val;
  emit("update:filterTo", val);
}

function toggleSort() {
  emit("update:sortAsc", !props.sortAsc);
}

function jumpTo(century: string) {
  emit("jump", century);
}

const yearDisplay = computed(() => `${localFrom.value} — ${localTo.value}`);
</script>

<template>
  <div class="tl-controls" role="toolbar" aria-label="Filtros de cronología">
    <div class="tl-controls-sort">
      <button class="btn-sort" @click="toggleSort">
        CRONOLÓGICO {{ sortAsc ? "↑" : "↓" }}
      </button>
    </div>

    <div class="tl-controls-jump">
      <span class="jump-label" aria-hidden="true">IR A:</span>
      <button class="btn-jump" @click="jumpTo('19')">SIGLO XIX</button>
      <button class="btn-jump" @click="jumpTo('20')">SIGLO XX</button>
      <button class="btn-jump" @click="jumpTo('21')">SIGLO XXI</button>
    </div>

    <div class="tl-controls-filter">
      <div class="filter-range-wrap">
        <span class="filter-label" aria-hidden="true">PERÍODO</span>
        <div class="filter-range-inputs">
          <input
            type="range"
            :min="minYear"
            :max="maxYear"
            :value="localFrom"
            aria-label="Año desde"
            @input="onFromInput"
          >
          <input
            type="range"
            :min="minYear"
            :max="maxYear"
            :value="localTo"
            aria-label="Año hasta"
            @input="onToInput"
          >
        </div>
        <span class="filter-year-display" role="status" aria-live="polite">
          {{ yearDisplay }}
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.tl-controls {
  position: sticky;
  top: 64px;
  z-index: 900;
  background: var(--color-surface-2);
  border-bottom: 1px solid var(--color-border);
  padding: 12px 48px;
  display: flex;
  align-items: center;
  gap: 24px;
  flex-wrap: wrap;
}

.btn-sort {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.16em;
  color: var(--color-muted);
  background: transparent;
  border: 1px solid var(--color-border);
  padding: 5px 12px;
  cursor: pointer;
  border-radius: var(--radius-sm);
  transition:
    border-color 0.2s,
    color 0.2s;
  white-space: nowrap;
}

.btn-sort:hover {
  border-color: var(--color-muted);
  color: var(--color-text);
}

.tl-controls-jump {
  display: flex;
  align-items: center;
  gap: 6px;
}

.jump-label {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.2em;
  color: var(--color-muted);
  margin-right: 4px;
  text-transform: uppercase;
}

.btn-jump {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.12em;
  color: var(--color-muted);
  background: transparent;
  border: 1px solid var(--color-border);
  padding: 4px 10px;
  cursor: pointer;
  border-radius: 2px;
  transition:
    border-color 0.2s,
    color 0.2s;
  white-space: nowrap;
}

.btn-jump:hover {
  border-color: var(--color-accent-dim);
  color: var(--color-accent);
}

.tl-controls-filter {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-left: auto;
}

.filter-range-wrap {
  display: flex;
  align-items: center;
  gap: 10px;
}

.filter-label {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.18em;
  color: var(--color-muted);
  text-transform: uppercase;
  white-space: nowrap;
}

.filter-year-display {
  font-family: var(--font-mono);
  font-size: 10px;
  color: var(--color-text);
  letter-spacing: 0.1em;
  min-width: 100px;
  text-align: center;
}

.filter-range-inputs {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

input[type="range"] {
  -webkit-appearance: none;
  appearance: none;
  width: 140px;
  height: 2px;
  background: var(--color-border);
  outline: none;
  cursor: pointer;
}

input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--color-accent);
  cursor: pointer;
  border: 2px solid var(--color-bg);
}

input[type="range"]::-moz-range-thumb {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--color-accent);
  cursor: pointer;
  border: 2px solid var(--color-bg);
  box-sizing: border-box;
}

@media (max-width: 768px) {
  .tl-controls {
    padding: 12px 20px;
    gap: 8px;
  }

  .tl-controls-filter {
    margin-left: 0;
    width: 100%;
  }

  .filter-range-wrap {
    flex-wrap: wrap;
  }
}
</style>
