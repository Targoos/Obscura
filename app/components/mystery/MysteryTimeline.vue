<script setup lang="ts">
import type { TimelineEvent } from "~/types/mystery";

defineProps<{ events: TimelineEvent[] }>();

const containerEl = ref<HTMLElement | null>(null);
let obs: IntersectionObserver | null = null;

onMounted(() => {
  if (!containerEl.value) return;
  const items =
    containerEl.value.querySelectorAll<HTMLElement>(".timeline-event");

  obs = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry, i) => {
        if (entry.isIntersecting) {
          setTimeout(() => entry.target.classList.add("visible"), i * 90);
          obs!.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15 },
  );

  items.forEach((el) => obs!.observe(el));
});

onUnmounted(() => obs?.disconnect());
</script>

<template>
  <section class="cronologia" aria-label="Cronología del caso">
    <SectionLabel label="// 03 — CRONOLOGÍA" />
    <div ref="containerEl" class="timeline" role="list">
      <div
        v-for="event in events"
        :key="event.id"
        class="timeline-event"
        role="listitem"
      >
        <div class="timeline-dot" aria-hidden="true" />
        <div class="timeline-year">{{ event.year }}</div>
        <div class="timeline-title">{{ event.title }}</div>
        <div class="timeline-desc">{{ event.description }}</div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.cronologia {
  margin-bottom: 60px;
}

.timeline {
  position: relative;
  padding-left: 44px;
}

.timeline::before {
  content: "";
  position: absolute;
  left: 12px;
  top: 8px;
  bottom: 8px;
  width: 0;
  border-left: 1px dashed var(--color-accent-dim);
}

.timeline-event {
  position: relative;
  margin-bottom: 34px;
  opacity: 0;
  transform: translateX(-12px);
  transition:
    opacity 0.55s ease,
    transform 0.55s ease;
}

.timeline-event:last-child {
  margin-bottom: 0;
}

.timeline-event.visible {
  opacity: 1;
  transform: translateX(0);
}

.timeline-dot {
  position: absolute;
  left: -38px;
  top: 6px;
  width: 9px;
  height: 9px;
  border: 1.5px solid var(--color-accent);
  border-radius: 50%;
  background: var(--color-bg);
}

.timeline-dot::after {
  content: "";
  position: absolute;
  inset: 2px;
  border-radius: 50%;
  background: var(--color-accent-dim);
  opacity: 0;
  transition: opacity 0.3s;
}

.timeline-event.visible .timeline-dot::after {
  opacity: 1;
}

.timeline-year {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.22em;
  color: var(--color-accent);
  margin-bottom: 5px;
}

.timeline-title {
  font-family: var(--font-body);
  font-size: 14.5px;
  font-weight: 600;
  color: var(--color-text);
  letter-spacing: 0.02em;
  margin-bottom: 6px;
}

.timeline-desc {
  font-family: var(--font-body);
  font-size: 13.5px;
  color: var(--color-muted);
  line-height: 1.6;
}

@media (prefers-reduced-motion: reduce) {
  .timeline-event {
    opacity: 1;
    transform: none;
    transition: none;
  }
}
</style>
