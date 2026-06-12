<script setup lang="ts">
import type { Mystery, Source } from "~/types/mystery";

const props = defineProps<{
  mystery: Mystery;
  sources: Source[];
  locationName?: string;
  victims?: string;
  classifiedPeriod?: string;
  isSaved?: boolean;
  userRating?: number;
}>();

const emit = defineEmits<{
  "save-toggle": [saved: boolean];
  rate: [value: number];
}>();

const saved = ref(props.isSaved ?? false);
const rating = ref(props.userRating ?? 0);

function toggleSave() {
  saved.value = !saved.value;
  emit("save-toggle", saved.value);
}

function onRate(v: number) {
  rating.value = v;
  emit("rate", v);
}

const classificationLabel = computed(() => {
  const map: Record<string, string> = {
    disturbing: "PERTURBADOR",
    extreme: "EXTREMO",
    classified: "CLASIFICADO",
  };
  return map[props.mystery.classification_level] ?? "PERTURBADOR";
});

const caseId = computed(() => {
  const year = props.mystery.year_occurred ?? "0000";
  const shortId = props.mystery.id.replace(/-/g, "").slice(0, 4).toUpperCase();
  return `OBX-${year}-${shortId}`;
});

const statusDisplay = computed(() => {
  const m = props.mystery;
  if (m.classification_level === "classified")
    return { text: "CLASIFICADO", color: "var(--color-classified)" };
  if (m.status === "archived")
    return { text: "ARCHIVADO", color: "var(--color-muted)" };
  if (m.status === "published")
    return { text: "ABIERTO", color: "var(--color-open)" };
  return { text: "SIN RESOLVER", color: "var(--color-warning)" };
});

const dateDisplay = computed(() => {
  const y = props.mystery.year_occurred;
  return y ? `${y}` : "—";
});

const coordsDisplay = computed(() => {
  const { latitude: lat, longitude: lng } = props.mystery;
  if (lat == null || lng == null) return "—";
  const latStr = `${Math.abs(lat).toFixed(2)}°${lat >= 0 ? "N" : "S"}`;
  const lngStr = `${Math.abs(lng).toFixed(2)}°${lng >= 0 ? "E" : "W"}`;
  return `${latStr} · ${lngStr}`;
});
</script>

<template>
  <div class="dossier-stack">
    <!-- Dossier metadata card -->
    <div class="dossier-card">
      <div class="dossier-head">
        <span class="dossier-head-label">// EXPEDIENTE</span>
        <span class="dossier-head-class">{{ classificationLabel }}</span>
      </div>
      <div class="dossier-row">
        <span class="dossier-key">ID</span>
        <span class="dossier-val">{{ caseId }}</span>
      </div>
      <div class="dossier-row">
        <span class="dossier-key">ESTADO</span>
        <span class="dossier-val" :style="{ color: statusDisplay.color }">{{
          statusDisplay.text
        }}</span>
      </div>
      <div class="dossier-row">
        <span class="dossier-key">FECHA</span>
        <span class="dossier-val">{{ dateDisplay }}</span>
      </div>
      <div v-if="locationName" class="dossier-row">
        <span class="dossier-key">UBICACIÓN</span>
        <span class="dossier-val">{{ locationName }}</span>
      </div>
      <div v-if="mystery.country" class="dossier-row">
        <span class="dossier-key">PAÍS</span>
        <span class="dossier-val">
          <span aria-hidden="true">{{ mystery.country.flag_emoji }}</span>
          {{ mystery.country.name.toUpperCase() }}
        </span>
      </div>
      <div v-if="mystery.category" class="dossier-row">
        <span class="dossier-key">CATEGORÍA</span>
        <span class="dossier-val">{{
          mystery.category.name.toUpperCase()
        }}</span>
      </div>
      <div v-if="victims" class="dossier-row">
        <span class="dossier-key">VÍCTIMAS</span>
        <span class="dossier-val dossier-val--accent">{{ victims }}</span>
      </div>
      <div v-if="mystery.latitude != null" class="dossier-row">
        <span class="dossier-key">COORDS</span>
        <span class="dossier-val">{{ coordsDisplay }}</span>
      </div>
      <div v-if="classifiedPeriod" class="dossier-row">
        <span class="dossier-key">CLASIFICACIÓN</span>
        <span class="dossier-val">{{ classifiedPeriod }}</span>
      </div>
    </div>

    <!-- Actions: save + rating -->
    <div class="actions-card">
      <button
        :class="['save-btn', { saved }]"
        :aria-pressed="saved"
        aria-label="Guardar en favoritos"
        @click="toggleSave"
      >
        <svg
          viewBox="0 0 16 16"
          :fill="saved ? 'currentColor' : 'none'"
          stroke="currentColor"
          stroke-width="1.5"
          width="13"
          height="13"
          aria-hidden="true"
        >
          <path d="M3 2h10a1 1 0 0 1 1 1v10l-6-3-6 3V3a1 1 0 0 1 1-1z" />
        </svg>
        {{ saved ? "GUARDADO" : "GUARDAR" }}
      </button>
      <RatingStars :value="rating" @change="onRate" />
    </div>

    <!-- Sources -->
    <div v-if="sources.length" class="fuentes-card">
      <div class="sidebar-section-label">// FUENTES DOCUMENTALES</div>
      <div
        v-for="(source, index) in sources"
        :key="source.id"
        class="fuente-item"
      >
        <span class="fuente-num">{{ String(index + 1).padStart(2, "0") }}</span>
        <span class="fuente-text">
          <a
            v-if="source.url && source.url.startsWith('http')"
            :href="source.url"
            target="_blank"
            rel="noopener noreferrer"
            class="fuente-ref"
            >{{ source.title }}</a
          >
          <template v-else>{{ source.title }}</template>
          <template v-if="source.year">
            — <span class="fuente-ref">{{ source.year }}</span></template
          >
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dossier-stack {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

/* ── Dossier card ── */
.dossier-card {
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.dossier-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 11px 16px;
  border-bottom: 1px solid var(--color-border);
}

.dossier-head-label {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.dossier-head-class {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.2em;
  color: var(--color-classified);
  text-transform: uppercase;
}

.dossier-row {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  padding: 9px 16px;
  border-bottom: 1px solid rgba(31, 31, 31, 0.8);
  gap: 10px;
}

.dossier-row:last-child {
  border-bottom: none;
}

.dossier-key {
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.18em;
  color: var(--color-muted);
  text-transform: uppercase;
  flex-shrink: 0;
}

.dossier-val {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--color-text);
  text-align: right;
  word-break: break-word;
  letter-spacing: 0.04em;
}

.dossier-val--accent {
  color: var(--color-accent);
}

/* ── Actions card ── */
.actions-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 14px 16px;
  display: flex;
  align-items: center;
  gap: 14px;
}

.save-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background: transparent;
  border: 1px solid var(--color-border);
  color: var(--color-muted);
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 9px 14px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition:
    border-color 0.2s,
    color 0.2s,
    background 0.2s;
}

.save-btn:hover {
  border-color: var(--color-accent);
  color: var(--color-text);
}

.save-btn.saved {
  border-color: var(--color-accent);
  color: var(--color-accent);
  background: rgba(204, 0, 0, 0.06);
}

/* ── Sources card ── */
.fuentes-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 14px 16px;
}

.sidebar-section-label {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
  margin-bottom: 12px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--color-border);
}

.fuente-item {
  display: flex;
  gap: 10px;
  align-items: flex-start;
  padding: 8px 0;
  border-bottom: 1px solid rgba(31, 31, 31, 0.7);
}

.fuente-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}

.fuente-num {
  font-family: var(--font-mono);
  font-size: 9.5px;
  color: var(--color-accent);
  flex-shrink: 0;
  padding-top: 1px;
  width: 16px;
}

.fuente-text {
  font-family: var(--font-mono);
  font-size: 10.5px;
  color: var(--color-muted);
  line-height: 1.5;
  letter-spacing: 0.02em;
}

.fuente-ref {
  color: var(--color-text);
  text-decoration: none;
}

a.fuente-ref:hover {
  color: var(--color-accent);
}
</style>
