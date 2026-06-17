<script setup lang="ts">
import type { BadgeVariant } from "~/components/ui/StatusBadge.vue";

export interface TimelineEventData {
  id: string;
  year: number;
  title: string;
  status: BadgeVariant;
  categoria: string;
  country: string;
  summary: string;
  slug: string;
}

defineProps<{
  event: TimelineEventData;
  side: "left" | "right";
}>();

const entryEl = ref<HTMLElement | null>(null);

onMounted(() => {
  if (!entryEl.value) return;
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add("revealed");
          observer.unobserve(e.target);
        }
      });
    },
    { threshold: 0.1 },
  );
  observer.observe(entryEl.value);
});
</script>

<template>
  <article
    ref="entryEl"
    class="tl-entry"
    :class="[`tl-entry--${side}`]"
    :data-year="event.year"
    :aria-label="`${event.year}: ${event.title}`"
  >
    <!-- LEFT SIDE: year (side=left) or card (side=right) -->
    <div class="tl-entry-left">
      <template v-if="side === 'left'">
        <div class="tl-year tl-year--left">{{ event.year }}</div>
      </template>
      <template v-else>
        <div class="tl-card">
          <StatusBadge :variant="event.status" />
          <div class="tl-card-id">{{ event.id }}</div>
          <h3 class="tl-card-title">{{ event.title }}</h3>
          <p class="tl-card-summary">{{ event.summary }}</p>
          <div class="tl-card-tags">
            <span class="tl-card-tag">{{ event.categoria }}</span>
            <span class="tl-card-tag">{{ event.country }}</span>
          </div>
          <NuxtLink :to="`/caso/${event.slug}`" class="tl-card-link">
            VER EXPEDIENTE →
          </NuxtLink>
        </div>
      </template>
    </div>

    <!-- CENTER connector -->
    <div class="tl-connector" aria-hidden="true">
      <div class="tl-connector-dot" />
    </div>

    <!-- RIGHT SIDE: card (side=left) or year (side=right) -->
    <div class="tl-entry-right">
      <template v-if="side === 'left'">
        <div class="tl-card">
          <StatusBadge :variant="event.status" />
          <div class="tl-card-id">{{ event.id }}</div>
          <h3 class="tl-card-title">{{ event.title }}</h3>
          <p class="tl-card-summary">{{ event.summary }}</p>
          <div class="tl-card-tags">
            <span class="tl-card-tag">{{ event.categoria }}</span>
            <span class="tl-card-tag">{{ event.country }}</span>
          </div>
          <NuxtLink :to="`/caso/${event.slug}`" class="tl-card-link">
            VER EXPEDIENTE →
          </NuxtLink>
        </div>
      </template>
      <template v-else>
        <div class="tl-year tl-year--right">{{ event.year }}</div>
      </template>
    </div>
  </article>
</template>

<style scoped>
.tl-entry {
  display: grid;
  grid-template-columns: 1fr 40px 1fr;
  margin-bottom: 20px;
  align-items: start;
  opacity: 0;
  transform: translateY(20px);
  transition:
    opacity 0.5s ease,
    transform 0.5s ease;
}

.tl-entry.revealed {
  opacity: 1;
  transform: translateY(0);
}

.tl-connector {
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding-top: 20px;
}

.tl-connector-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  border: 2px solid var(--color-accent);
  background: var(--color-bg);
  flex-shrink: 0;
}

.tl-year {
  font-family: var(--font-display);
  font-size: 32px;
  font-weight: 700;
  color: var(--color-accent);
  letter-spacing: 0.06em;
  line-height: 1;
  padding: 16px 20px 16px 0;
}

.tl-year--left {
  text-align: right;
}

.tl-year--right {
  text-align: left;
  padding: 16px 0 16px 20px;
}

.tl-card {
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 20px 24px;
  transition:
    border-color 0.2s ease,
    box-shadow 0.2s ease;
}

.tl-card:hover {
  border-color: var(--color-accent-dim);
  box-shadow: 0 0 20px rgba(204, 0, 0, 0.08);
}

.tl-card-id {
  font-family: var(--font-mono);
  font-size: 9px;
  color: var(--color-muted);
  letter-spacing: 0.22em;
  margin: 6px 0 4px;
}

.tl-card-title {
  font-family: var(--font-display);
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 0.06em;
  color: var(--color-text);
  margin: 4px 0 10px;
  line-height: 1.3;
}

.tl-card-summary {
  font-family: var(--font-body);
  font-size: 13px;
  color: var(--color-muted);
  line-height: 1.55;
  margin-bottom: 12px;
}

.tl-card-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-bottom: 12px;
}

.tl-card-tag {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  padding: 3px 8px;
  border-radius: 2px;
  color: var(--color-muted);
}

.tl-card-link {
  font-family: var(--font-mono);
  font-size: 10px;
  color: var(--color-muted);
  text-decoration: none;
  letter-spacing: 0.12em;
  transition: color 0.2s;
}

.tl-card-link:hover {
  color: var(--color-accent);
}

@media (max-width: 768px) {
  .tl-entry {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 24px;
    padding-left: 24px;
    position: relative;
  }

  .tl-entry .tl-connector {
    position: absolute;
    left: -16px;
    top: 6px;
    padding-top: 0;
  }

  .tl-entry-left,
  .tl-entry-right {
    width: 100%;
  }

  .tl-year,
  .tl-year--left,
  .tl-year--right {
    font-size: 22px;
    text-align: left;
    padding: 0 0 8px 0;
    order: -1;
  }

  .tl-entry--right .tl-entry-right {
    order: -1;
  }

  .tl-card {
    width: 100%;
    order: 1;
  }
}
</style>
