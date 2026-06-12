<script setup lang="ts">
type SortKey = "created_at" | "year_occurred" | "views_count" | "rating_avg";

interface SortOption {
  label: string;
  sortBy: SortKey;
  order: "asc" | "desc";
}

const props = defineProps<{
  showing: number;
  total: number;
  sortBy: SortKey;
  order: "asc" | "desc";
}>();

const emit = defineEmits<{
  (e: "update:sortBy", value: SortKey): void;
  (e: "update:order", value: "asc" | "desc"): void;
}>();

const SORT_OPTIONS: SortOption[] = [
  { label: "MÁS RECIENTE", sortBy: "created_at", order: "desc" },
  { label: "MÁS ANTIGUO", sortBy: "year_occurred", order: "asc" },
  { label: "MÁS VISTO", sortBy: "views_count", order: "desc" },
  { label: "MEJOR VALORADO", sortBy: "rating_avg", order: "desc" },
];

const isOpen = ref(false);
const dropRef = ref<HTMLDivElement | null>(null);

const currentLabel = computed(
  () =>
    SORT_OPTIONS.find(
      (o) => o.sortBy === props.sortBy && o.order === props.order,
    )?.label ?? "MÁS RECIENTE",
);

function selectSort(opt: SortOption) {
  emit("update:sortBy", opt.sortBy);
  emit("update:order", opt.order);
  isOpen.value = false;
}

function handleOutside(e: MouseEvent) {
  if (dropRef.value && !dropRef.value.contains(e.target as Node)) {
    isOpen.value = false;
  }
}

onMounted(() => document.addEventListener("click", handleOutside));
onUnmounted(() => document.removeEventListener("click", handleOutside));
</script>

<template>
  <div class="results-header">
    <div class="results-count" role="status">
      MOSTRANDO {{ showing }} DE {{ total }}
    </div>

    <div ref="dropRef" class="sort-wrap">
      <button
        class="sort-btn"
        :aria-expanded="isOpen"
        aria-haspopup="listbox"
        @click.stop="isOpen = !isOpen"
      >
        ORDENAR: <span>{{ currentLabel }}</span>
        <span aria-hidden="true" style="font-size: 8px; margin-left: 4px"
          >▾</span
        >
      </button>

      <div
        v-show="isOpen"
        class="sort-dropdown"
        role="listbox"
        aria-label="Ordenar por"
      >
        <button
          v-for="opt in SORT_OPTIONS"
          :key="`${opt.sortBy}-${opt.order}`"
          class="sort-option"
          :class="{ selected: sortBy === opt.sortBy && order === opt.order }"
          role="option"
          :aria-selected="sortBy === opt.sortBy && order === opt.order"
          @click.stop="selectSort(opt)"
        >
          {{ opt.label }}
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.results-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 28px;
}

.results-count {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.sort-wrap {
  position: relative;
}

.sort-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
  background: none;
  border: 1px solid var(--color-border);
  border-radius: 0;
  padding: 6px 12px;
  cursor: pointer;
  transition:
    color 0.2s,
    border-color 0.2s;
}

.sort-btn:hover {
  color: var(--color-text);
  border-color: var(--color-muted);
}

.sort-dropdown {
  position: absolute;
  top: 100%;
  right: 0;
  min-width: 200px;
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  border-top: none;
  z-index: 300;
}

.sort-option {
  display: block;
  padding: 10px 16px;
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
  cursor: pointer;
  border: none;
  background: none;
  width: 100%;
  text-align: left;
  transition:
    color 0.15s,
    background 0.15s;
}

.sort-option:hover {
  color: var(--color-text);
  background: rgba(255, 255, 255, 0.03);
}

.sort-option.selected {
  color: var(--color-text);
}
</style>
