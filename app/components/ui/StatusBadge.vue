<script setup lang="ts">
export type BadgeVariant =
  | "abierto"
  | "archivado"
  | "clasificado"
  | "sin-resolver";

const props = defineProps<{ variant: BadgeVariant }>();

const config: Record<BadgeVariant, string> = {
  abierto: "CASO ABIERTO",
  archivado: "ARCHIVADO",
  clasificado: "CLASIFICADO",
  "sin-resolver": "SIN RESOLVER",
};
</script>

<template>
  <span :class="['badge', `badge--${props.variant}`]">
    {{ config[props.variant] }}
  </span>
</template>

<style scoped>
.badge {
  font-family: var(--font-mono);
  font-size: 8.5px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  padding: 3px 8px;
  border-radius: var(--radius-sm);
  border: 1px solid transparent;
  white-space: nowrap;
}

.badge--abierto {
  color: var(--color-open);
  border-color: rgba(34, 153, 77, 0.55);
  background: rgba(34, 153, 77, 0.07);
}

.badge--archivado {
  color: var(--color-muted);
  border-color: rgba(68, 68, 68, 0.55);
  background: rgba(68, 68, 68, 0.07);
}

.badge--clasificado {
  color: var(--color-classified);
  border-color: rgba(255, 102, 0, 0.5);
  background: rgba(255, 102, 0, 0.06);
}

.badge--sin-resolver {
  color: var(--color-accent);
  border-color: rgba(204, 0, 0, 0.5);
  background: rgba(204, 0, 0, 0.06);
}
</style>
