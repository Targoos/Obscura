<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

const route = useRoute();
const slug = computed(() => route.params.slug as string);

const { fetchBySlug, fetchRelated } = useMysteries();

const { data: mystery } = await useAsyncData(
  () => `caso-${slug.value}`,
  () => fetchBySlug(slug.value),
  { watch: [slug] },
);

if (!mystery.value) {
  throw createError({
    statusCode: 404,
    statusMessage: "Caso no encontrado",
    fatal: true,
  });
}

const { data: related } = await useAsyncData(
  () => `caso-related-${slug.value}`,
  () =>
    mystery.value
      ? fetchRelated(mystery.value.id, mystery.value.category_id)
      : Promise.resolve([] as Mystery[]),
  { default: () => [] as Mystery[], watch: [mystery] },
);

useHead(() => ({ title: `${mystery.value?.title ?? "Caso"} — Obscura` }));

const timeline = computed(() =>
  [...(mystery.value?.timeline_events ?? [])].sort(
    (a, b) => a.order - b.order || a.year - b.year,
  ),
);
const theories = computed(() =>
  [...(mystery.value?.theories ?? [])].sort(
    (a, b) => b.credibility_score - a.credibility_score,
  ),
);
const sources = computed(() => mystery.value?.sources ?? []);

const paragraphs = computed(() => {
  const desc = mystery.value?.description?.trim();
  if (desc) return desc.split(/\n\n+/).filter(Boolean);
  const summary = mystery.value?.summary?.trim();
  return summary ? [summary] : [];
});

const hasCoords = computed(
  () => mystery.value?.latitude != null && mystery.value?.longitude != null,
);

const mapLocation = computed(
  () => mystery.value?.country?.name ?? mystery.value?.title ?? "—",
);

const coordsDisplay = computed(() => {
  const lat = mystery.value?.latitude;
  const lng = mystery.value?.longitude;
  if (lat == null || lng == null) return "—";
  const latStr = `${Math.abs(lat).toFixed(2)}°${lat >= 0 ? "N" : "S"}`;
  const lngStr = `${Math.abs(lng).toFixed(2)}°${lng >= 0 ? "E" : "W"}`;
  return `${latStr} · ${lngStr}`;
});

interface MockComment {
  id: string;
  initials: string;
  username: string;
  date: string;
  content: string;
  verified?: boolean;
}

const COMMENTS: MockComment[] = [
  {
    id: "c1",
    initials: "AK",
    username: "anatoliy_k",
    date: "12 MAR 2024 — 02:17H",
    content:
      "El detalle de las fracturas óseas sin traumatismo externo es lo que siempre me ha resultado más perturbador. Un médico forense con treinta años de experiencia declaró nunca haber visto nada semejante en toda su carrera. La teoría de la avalancha no explica esto. Nunca lo ha explicado.",
    verified: true,
  },
  {
    id: "c2",
    initials: "RV",
    username: "researcher_v",
    date: "08 MAR 2024 — 19:54H",
    content:
      "Lo de los archivos desaparecidos del expediente forense es crucial y no se menciona suficiente. No es que los archivos no existan — es que existen pero tienen páginas arrancadas. Alguien tomó esa decisión conscientemente.",
  },
  {
    id: "c3",
    initials: "MF",
    username: "mari_f",
    date: "02 MAR 2024 — 11:33H",
    content:
      "Trabajé tres años en el Instituto Politécnico de los Urales. Lo que nadie menciona es que los familiares de las víctimas nunca recibieron una explicación coherente. Fueron silenciados activamente durante décadas. El edificio principal aún tiene una placa. Nadie habla de ella.",
  },
];

/* ─── Auth state (mock) ─── */
const isAuthenticated = ref(false);
const commentText = ref("");

function handleAuth() {
  isAuthenticated.value = true;
}

/* ─── Scroll reveal — port of original HTML JS ─── */
let revObs: IntersectionObserver | null = null;

onMounted(() => {
  const els = document.querySelectorAll<HTMLElement>(".reveal");
  revObs = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("visible");
          revObs!.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.08 },
  );
  els.forEach((el) => revObs!.observe(el));
});

onUnmounted(() => revObs?.disconnect());
</script>

<template>
  <div v-if="mystery">
    <MysteryHero :mystery="mystery" />

    <main id="expediente" class="page-content">
      <div class="two-col">
        <!-- LEFT COLUMN -->
        <div class="col-main">
          <!-- Editorial summary -->
          <section
            class="editorial-summary reveal"
            aria-label="Resumen editorial"
          >
            <p v-for="(parrafo, i) in paragraphs" :key="i">{{ parrafo }}</p>
          </section>

          <!-- Timeline -->
          <MysteryTimeline v-if="timeline.length" :events="timeline" />

          <!-- Theories -->
          <MysteryTheories v-if="theories.length" :theories="theories" />
        </div>
        <!-- end col-main -->

        <!-- RIGHT COLUMN — sidebar -->
        <aside class="col-sidebar" aria-label="Datos del expediente">
          <DossierSidebar :mystery="mystery" :sources="sources" />
          <MapPlaceholder
            v-if="hasCoords"
            :location-name="mapLocation"
            :coords-display="coordsDisplay"
          />
          <MysteryRelated v-if="related.length" :mysteries="related" />
        </aside>
        <!-- end col-sidebar -->
      </div>
      <!-- end two-col -->

      <!-- COMMENTS -->
      <section class="comentarios-section" aria-labelledby="comments-heading">
        <SectionLabel
          id="comments-heading"
          label="// 06 — COMENTARIOS DEL ARCHIVO"
        />

        <!-- Unauthenticated notice -->
        <div v-if="!isAuthenticated" class="auth-notice">
          <span class="auth-notice-text">
            Debes <strong>iniciar sesión</strong> para añadir un análisis al
            expediente.
          </span>
          <button class="auth-btn" @click="handleAuth">
            ACCEDER AL ARCHIVO
          </button>
        </div>

        <!-- Authenticated comment form -->
        <div v-else class="comment-form">
          <div class="comment-form-label">// AÑADIR ANÁLISIS AL EXPEDIENTE</div>
          <textarea
            v-model="commentText"
            class="comment-textarea"
            placeholder="Tu análisis, hipótesis o evidencia adicional..."
            rows="4"
            aria-label="Escribe tu comentario"
          />
          <div class="comment-form-footer">
            <button class="submit-btn">ENVIAR ANÁLISIS →</button>
          </div>
        </div>

        <!-- Approved comments -->
        <div class="comments-list" aria-label="Comentarios del expediente">
          <div
            v-for="comment in COMMENTS"
            :key="comment.id"
            class="comment-item"
          >
            <div class="comment-avatar" aria-hidden="true">
              {{ comment.initials }}
            </div>
            <div class="comment-body">
              <div class="comment-meta">
                <span class="comment-user">{{ comment.username }}</span>
                <span class="comment-date">{{ comment.date }}</span>
                <span v-if="comment.verified" class="comment-verified"
                  >✓ VERIFICADO</span
                >
              </div>
              <p class="comment-text">{{ comment.content }}</p>
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<style scoped>
.page-content {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 48px;
}

/* ── Two-column layout ── */
.two-col {
  display: grid;
  grid-template-columns: 1fr 368px;
  gap: 52px;
  padding-top: 64px;
  padding-bottom: 80px;
  align-items: start;
}

.col-main {
  min-width: 0;
}

.col-sidebar {
  position: sticky;
  top: calc(64px + 20px);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

/* ── Editorial summary ── */
.editorial-summary {
  margin-bottom: 56px;
}

.editorial-summary p {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 19.5px;
  line-height: 1.78;
  color: rgba(212, 212, 212, 0.88);
  margin-bottom: 22px;
  letter-spacing: 0.01em;
}

.editorial-summary p:last-child {
  margin-bottom: 0;
}

.editorial-summary p:first-child::first-letter {
  font-family: var(--font-display);
  font-size: 58px;
  font-weight: 700;
  float: left;
  line-height: 0.82;
  margin-right: 8px;
  margin-top: 5px;
  color: var(--color-accent);
}

/* ── Hechos conocidos ── */
.hechos {
  margin-bottom: 60px;
}

.hecho-item {
  display: flex;
  gap: 14px;
  align-items: flex-start;
  padding: 15px 0;
  border-bottom: 1px solid var(--color-border);
  transition: background 0.2s;
}

.hecho-item:first-of-type {
  border-top: 1px solid var(--color-border);
}

.hecho-item:hover {
  background: rgba(255, 255, 255, 0.01);
}

.hecho-num {
  font-family: var(--font-mono);
  font-size: 10px;
  color: var(--color-accent);
  letter-spacing: 0.18em;
  padding-top: 3px;
  flex-shrink: 0;
  width: 20px;
}

.hecho-chevron {
  color: var(--color-accent);
  flex-shrink: 0;
  padding-top: 2px;
  font-size: 14px;
  font-weight: 300;
  line-height: 1.4;
}

.hecho-text {
  font-family: var(--font-body);
  font-size: 14.5px;
  color: var(--color-text);
  line-height: 1.6;
}

/* ── Comments section ── */
.comentarios-section {
  border-top: 1px solid var(--color-border);
  padding: 60px 0 80px;
}

.auth-notice {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 18px 22px;
  margin-bottom: 40px;
}

.auth-notice-text {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--color-muted);
  letter-spacing: 0.1em;
}

.auth-notice-text strong {
  color: var(--color-text);
  font-weight: 500;
}

.auth-btn {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  background: transparent;
  border: 1px solid var(--color-accent);
  padding: 9px 20px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  white-space: nowrap;
  transition:
    background 0.2s,
    color 0.2s;
}

.auth-btn:hover {
  background: var(--color-accent);
  color: #fff;
}

/* Comment form (authenticated) */
.comment-form {
  margin-bottom: 40px;
}

.comment-form-label {
  font-family: var(--font-mono);
  font-size: 9.5px;
  letter-spacing: 0.24em;
  color: var(--color-muted);
  margin-bottom: 12px;
  text-transform: uppercase;
}

.comment-textarea {
  width: 100%;
  background: var(--color-bg);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  color: var(--color-text);
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.6;
  padding: 14px 16px;
  resize: vertical;
  min-height: 96px;
  outline: none;
  transition: border-color 0.2s;
}

.comment-textarea:focus {
  border-color: var(--color-accent);
}

.comment-form-footer {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}

.submit-btn {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  background: transparent;
  border: 1px solid var(--color-accent);
  padding: 9px 22px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition:
    background 0.2s,
    color 0.2s;
}

.submit-btn:hover {
  background: var(--color-accent);
  color: #fff;
}

/* Comment list */
.comments-list {
  display: flex;
  flex-direction: column;
}

.comment-item {
  display: flex;
  gap: 16px;
  padding: 22px 0;
  border-bottom: 1px solid var(--color-border);
}

.comment-item:first-child {
  border-top: 1px solid var(--color-border);
}

.comment-avatar {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-sm);
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 500;
  color: var(--color-muted);
}

.comment-body {
  flex: 1;
  min-width: 0;
}

.comment-meta {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 9px;
}

.comment-user {
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 500;
  color: var(--color-text);
  letter-spacing: 0.1em;
}

.comment-date {
  font-family: var(--font-mono);
  font-size: 10px;
  color: var(--color-muted);
  letter-spacing: 0.08em;
}

.comment-verified {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.16em;
  color: var(--color-open);
  text-transform: uppercase;
}

.comment-text {
  font-family: var(--font-body);
  font-size: 14px;
  color: rgba(212, 212, 212, 0.85);
  line-height: 1.68;
}

/* ── Responsive ── */
@media (max-width: 820px) {
  .page-content {
    padding: 0 20px;
  }

  .two-col {
    grid-template-columns: 1fr;
    gap: 40px;
    padding-top: 40px;
  }

  .col-sidebar {
    position: static;
    order: -1;
  }
}
</style>
