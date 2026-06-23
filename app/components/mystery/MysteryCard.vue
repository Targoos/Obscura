<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

import type { BadgeVariant } from "~/components/ui/StatusBadge.vue";

const props = defineProps<{ mystery: Mystery }>();

const bgIndex = computed(() => {
  const hash = Array.from(props.mystery.id).reduce(
    (acc, c) => acc + c.charCodeAt(0),
    0,
  );
  return (hash % 10) + 1;
});

const badgeVariant = computed((): BadgeVariant => {
  if (props.mystery.status === "archived") return "archivado";
  switch (props.mystery.classification_level) {
    case "classified":
      return "clasificado";
    case "extreme":
      return "extremo";
    case "disturbing":
      return "perturbador";
    default:
      return "abierto";
  }
});
</script>

<template>
  <NuxtLink
    :to="`/caso/${mystery.slug}`"
    class="mystery-card"
    :aria-label="mystery.title"
  >
    <div class="card-image">
      <div
        :class="[
          'card-img-bg',
          { [`card-bg--${bgIndex}`]: !mystery.image_url },
        ]"
        :style="
          mystery.image_url
            ? {
                backgroundImage: `url(${mystery.image_url})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
              }
            : undefined
        "
        aria-hidden="true"
      />
      <div class="card-img-vignette" aria-hidden="true" />
      <StatusBadge :variant="badgeVariant" class="card-badge-pos" />
    </div>
    <div class="card-body">
      <h3 class="card-title text-mystery-title">{{ mystery.title }}</h3>
      <div class="card-meta text-mono-data">
        <span>{{ mystery.year_occurred ?? "—" }}</span>
        <span class="sep" aria-hidden="true">/</span>
        <span v-if="mystery.country">
          <span aria-hidden="true">{{ mystery.country.flag_emoji }}</span>
          {{ mystery.country.name.toUpperCase() }}
        </span>
      </div>
    </div>
  </NuxtLink>
</template>

<style scoped>
.mystery-card {
  position: relative;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  box-shadow: var(--shadow-card);
  overflow: hidden;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  text-decoration: none;
  transition:
    border-color var(--duration-base),
    transform var(--duration-base),
    box-shadow var(--duration-base);
}

.mystery-card:hover {
  border-color: rgba(122, 0, 0, 0.6);
  transform: translateY(-3px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.5);
}

.mystery-card::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--color-accent);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.35s ease;
}

.mystery-card:hover::after {
  transform: scaleX(1);
}

.card-image {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  overflow: hidden;
  flex-shrink: 0;
}

.card-img-bg {
  position: absolute;
  inset: 0;
  filter: grayscale(0.75) brightness(0.45) contrast(1.1);
  transition:
    transform 0.45s ease,
    filter 0.3s;
}

.mystery-card:hover .card-img-bg {
  transform: scale(1.04);
  filter: grayscale(0.5) brightness(0.55) contrast(1.1);
}

.card-img-vignette {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    transparent 30%,
    rgba(15, 15, 15, 0.7) 70%,
    rgba(15, 15, 15, 0.95) 100%
  );
}

.card-badge-pos {
  position: absolute;
  top: 12px;
  left: 12px;
  z-index: 2;
}

.card-body {
  padding: 14px 16px 16px;
  display: flex;
  flex-direction: column;
  gap: 9px;
  flex: 1;
}

.card-title {
  font-size: 13.5px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--color-text);
  line-height: 1.35;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-meta {
  font-size: 9.5px;
  letter-spacing: 0.12em;
  color: var(--color-muted);
  text-transform: uppercase;
  display: flex;
  align-items: center;
  gap: 8px;
}

.sep {
  color: var(--color-border);
}
</style>
