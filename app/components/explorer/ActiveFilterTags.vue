<script setup lang="ts">
export interface ActiveFilter {
  key: string;
  label: string;
  value: string;
}

defineProps<{
  filters: ActiveFilter[];
}>();

const emit = defineEmits<{
  remove: [filter: ActiveFilter];
}>();
</script>

<template>
  <div
    v-if="filters.length > 0"
    class="active-filters"
    aria-live="polite"
    aria-label="Filtros activos"
  >
    <span v-for="f in filters" :key="`${f.key}:${f.value}`" class="filter-tag">
      {{ f.label }}: {{ f.value }}
      <button
        class="tag-remove"
        :aria-label="`Eliminar filtro ${f.value}`"
        @click="emit('remove', f)"
      >
        ×
      </button>
    </span>
  </div>
</template>

<style scoped>
.active-filters {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 8px 48px;
  border-top: 1px solid var(--color-border);
  background: var(--color-surface);
}

.filter-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-text);
  background: rgba(204, 0, 0, 0.06);
  border: 1px solid rgba(204, 0, 0, 0.3);
  border-radius: var(--radius-sm);
  padding: 3px 8px 3px 10px;
}

.tag-remove {
  background: none;
  border: none;
  color: var(--color-muted);
  font-size: 14px;
  line-height: 1;
  padding: 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  transition: color 0.15s;
}

.tag-remove:hover {
  color: var(--color-accent);
}

@media (max-width: 768px) {
  .active-filters {
    padding: 8px 20px;
  }
}
</style>
