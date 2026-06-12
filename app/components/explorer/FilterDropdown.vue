<script setup lang="ts">
interface Option {
  value: string;
}

const props = defineProps<{
  label: string;
  options: Option[];
  modelValue: string;
}>();

const emit = defineEmits<{
  (e: "update:modelValue", value: string): void;
}>();

const isOpen = ref(false);
const rootRef = ref<HTMLDivElement | null>(null);

function toggle() {
  isOpen.value = !isOpen.value;
}

function select(value: string) {
  emit("update:modelValue", props.modelValue === value ? "" : value);
  isOpen.value = false;
}

function handleOutside(e: MouseEvent) {
  if (rootRef.value && !rootRef.value.contains(e.target as Node)) {
    isOpen.value = false;
  }
}

onMounted(() => document.addEventListener("click", handleOutside));
onUnmounted(() => document.removeEventListener("click", handleOutside));
</script>

<template>
  <div ref="rootRef" class="filter-drop">
    <button
      class="filter-btn"
      :class="{ active: !!modelValue, open: isOpen }"
      :aria-expanded="isOpen"
      aria-haspopup="listbox"
      @click.stop="toggle"
    >
      {{ label }}
      <span class="arrow" aria-hidden="true">▾</span>
    </button>

    <div
      v-show="isOpen"
      class="dropdown-panel"
      role="listbox"
      :aria-label="label"
    >
      <button
        v-for="opt in options"
        :key="opt.value"
        class="dropdown-item"
        :class="{ selected: modelValue === opt.value }"
        role="option"
        :aria-selected="modelValue === opt.value"
        @click.stop="select(opt.value)"
      >
        <span class="item-dot" aria-hidden="true" />
        {{ opt.value }}
      </button>
    </div>
  </div>
</template>

<style scoped>
.filter-drop {
  position: relative;
  flex-shrink: 0;
}

.filter-btn {
  font-family: var(--font-mono);
  font-size: 10.5px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: 0;
  padding: 0 14px;
  height: 32px;
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  white-space: nowrap;
  transition:
    border-color 0.2s,
    color 0.2s,
    box-shadow 0.2s;
}

.filter-btn:hover {
  border-color: var(--color-muted);
  color: var(--color-text);
}

.filter-btn.active {
  border-color: var(--color-accent);
  color: var(--color-text);
  box-shadow: 0 0 8px rgba(204, 0, 0, 0.15);
}

.arrow {
  font-size: 7px;
  opacity: 0.5;
  transition: transform 0.15s;
}

.filter-btn.open .arrow {
  transform: rotate(180deg);
}

.dropdown-panel {
  position: absolute;
  top: 100%;
  left: 0;
  min-width: 200px;
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  border-top: none;
  z-index: 300;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 16px;
  font-family: var(--font-mono);
  font-size: 10.5px;
  letter-spacing: 0.16em;
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

.dropdown-item:hover {
  color: var(--color-text);
  background: rgba(255, 255, 255, 0.03);
}

.dropdown-item.selected {
  color: var(--color-text);
}

.item-dot {
  width: 5px;
  height: 5px;
  border-radius: 50%;
  background: transparent;
  border: 1px solid var(--color-border);
  flex-shrink: 0;
  transition:
    background 0.15s,
    border-color 0.15s;
}

.dropdown-item.selected .item-dot {
  background: var(--color-accent);
  border-color: var(--color-accent);
}
</style>
