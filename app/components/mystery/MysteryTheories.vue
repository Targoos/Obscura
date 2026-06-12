<script setup lang="ts">
import type { Theory } from "~/types/mystery";

defineProps<{ theories: Theory[] }>();

function isUrl(s: string | null): s is string {
  return !!s && (s.startsWith("http://") || s.startsWith("https://"));
}
</script>

<template>
  <section class="teorias" aria-label="Teorías sobre el caso">
    <SectionLabel label="// 04 — TEORÍAS" />
    <div v-for="theory in theories" :key="theory.id" class="teoria-card">
      <div class="teoria-header">
        <div class="teoria-title">{{ theory.title }}</div>
        <div class="teoria-pct">{{ theory.credibility_score }}%</div>
      </div>
      <CredibilityBar :score="theory.credibility_score" />
      <div class="teoria-desc">{{ theory.description }}</div>
      <a
        v-if="isUrl(theory.source_url)"
        :href="theory.source_url"
        target="_blank"
        rel="noopener noreferrer"
        class="teoria-source"
        >{{ theory.source_url }}</a
      >
      <span v-else-if="theory.source_url" class="teoria-source">
        {{ theory.source_url }}
      </span>
    </div>
  </section>
</template>

<style scoped>
.teorias {
  margin-bottom: 48px;
}

.teoria-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 22px 24px;
  margin-bottom: 14px;
  transition:
    border-color 0.25s,
    transform 0.22s;
}

.teoria-card:last-child {
  margin-bottom: 0;
}

.teoria-card:hover {
  border-color: rgba(204, 0, 0, 0.35);
  transform: translateX(5px);
}

.teoria-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 14px;
  margin-bottom: 12px;
}

.teoria-title {
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  letter-spacing: 0.02em;
}

.teoria-pct {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--color-muted);
  flex-shrink: 0;
}

.teoria-desc {
  font-family: var(--font-body);
  font-size: 13.5px;
  color: var(--color-muted);
  line-height: 1.62;
  margin-bottom: 12px;
}

.teoria-source {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  font-family: var(--font-mono);
  font-size: 10px;
  color: rgba(204, 0, 0, 0.8);
  letter-spacing: 0.14em;
  text-transform: uppercase;
  text-decoration: none;
  transition: color 0.2s;
}

.teoria-source::before {
  content: "↗";
}

.teoria-source:hover {
  color: var(--color-text);
}
</style>
