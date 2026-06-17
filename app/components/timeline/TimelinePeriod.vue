<script setup lang="ts">
const props = defineProps<{
  decade: number;
  century: string;
}>();

const label = computed(() => `${props.decade} — ${props.decade + 9}`);
</script>

<template>
  <div
    :id="`period-${century}-${decade}`"
    class="tl-period"
    :data-decade="decade"
    :data-century="century"
  >
    <div class="tl-period-label" aria-hidden="true">
      <div class="tl-period-line" />
      <span class="tl-period-text">{{ label }}</span>
      <div class="tl-period-line" />
    </div>
    <slot />
  </div>
</template>

<style scoped>
.tl-period {
  margin-bottom: 16px;
}

.tl-period-label {
  display: flex;
  align-items: center;
  margin: 32px 0 20px;
}

.tl-period-line {
  flex: 1;
  height: 1px;
  background: var(--color-border);
}

.tl-period-text {
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-muted);
  padding: 0 20px;
  white-space: nowrap;
}
</style>
