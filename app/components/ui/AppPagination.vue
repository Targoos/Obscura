<script setup lang="ts">
const props = defineProps<{
  page: number;
  totalPages: number;
  hasPrev: boolean;
  hasNext: boolean;
}>();

const emit = defineEmits<{
  prev: [];
  next: [];
  goTo: [page: number];
}>();

const visiblePages = computed((): (number | "...")[] => {
  const total = props.totalPages;
  const current = props.page;

  if (total <= 7) {
    return Array.from({ length: total }, (_, i) => i + 1);
  }

  if (current <= 4) {
    return [1, 2, 3, 4, 5, "...", total];
  }

  if (current >= total - 3) {
    return [1, "...", total - 4, total - 3, total - 2, total - 1, total];
  }

  return [1, "...", current - 1, current, current + 1, "...", total];
});
</script>

<template>
  <nav class="pagination" aria-label="Páginas de resultados">
    <button
      class="pagination-btn nav-btn"
      :disabled="!hasPrev"
      @click="emit('prev')"
    >
      ← ANTERIOR
    </button>

    <template v-for="(p, i) in visiblePages" :key="i">
      <span
        v-if="p === '...'"
        class="pagination-btn ellipsis"
        aria-hidden="true"
      >
        ...
      </span>
      <button
        v-else
        class="pagination-btn"
        :class="{ active: p === page }"
        :aria-current="p === page ? 'page' : undefined"
        :aria-label="`Página ${p}`"
        @click="emit('goTo', p)"
      >
        {{ p }}
      </button>
    </template>

    <button
      class="pagination-btn nav-btn"
      :disabled="!hasNext"
      @click="emit('next')"
    >
      SIGUIENTE →
    </button>
  </nav>
</template>

<style scoped>
.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  padding: 0 48px 64px;
}

.pagination-btn {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: 0;
  padding: 0 12px;
  height: 34px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 34px;
  cursor: pointer;
  transition:
    background 0.15s,
    color 0.15s,
    border-color 0.15s;
}

.pagination-btn:hover:not(.active):not(.ellipsis):not(:disabled) {
  background: var(--color-surface-2);
  color: var(--color-text);
  border-color: var(--color-muted);
}

.pagination-btn.active {
  background: var(--color-accent);
  border-color: var(--color-accent);
  color: #ffffff;
  cursor: default;
}

.pagination-btn.ellipsis {
  border-color: transparent;
  background: transparent;
  cursor: default;
}

.pagination-btn.nav-btn {
  letter-spacing: 0.14em;
  padding: 0 16px;
}

.pagination-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

@media (max-width: 768px) {
  .pagination {
    padding: 0 20px 48px;
    flex-wrap: wrap;
  }
}
</style>
