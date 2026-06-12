<script setup lang="ts">
import type { Mystery, TimelineEvent, Theory, Source } from "~/types/mystery";

const route = useRoute();
const _slug = computed(() => route.params.slug as string);

/* ─── Mock data ─── */

const MYSTERY: Mystery = {
  id: "dyatlov-pass-1959",
  slug: "masacre-paso-dyatlov",
  title: "La Masacre del Paso Dyatlov",
  summary:
    "Nueve excursionistas expertos mueren en circunstancias inexplicables en las montañas Urales. La investigación fue archivada. Los archivos, clasificados durante treinta años.",
  description:
    "En la noche del 1 de febrero de 1959, nueve experimentados excursionistas soviéticos ascendían el monte Kholat Syakhl en los Urales del Norte.",
  status: "published",
  classification_level: "extreme",
  image_url: null,
  latitude: 61.75,
  longitude: 59.45,
  year_occurred: 1959,
  views_count: 847293,
  rating_avg: 4.7,
  rating_count: 2341,
  category_id: "cat1",
  country_id: "ru",
  created_at: "2024-01-01T00:00:00Z",
  updated_at: "2024-03-15T00:00:00Z",
  published_at: "2024-01-01T00:00:00Z",
  created_by: "admin",
  category: {
    id: "cat1",
    name: "Suceso Inexplicable",
    slug: "suceso-inexplicable",
    description: null,
    icon: null,
    color: null,
    created_at: "2024-01-01T00:00:00Z",
  },
  country: {
    id: "ru",
    name: "Rusia",
    code: "RU",
    flag_emoji: "🇷🇺",
    continent: "Europe",
    created_at: "2024-01-01T00:00:00Z",
  },
};

const TIMELINE: TimelineEvent[] = [
  {
    id: "tl1",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "El grupo parte de Sverdlovsk",
    description:
      "Nueve excursionistas del Instituto Politécnico de los Urales, liderados por Igor Dyatlov, inician su expedición invernal de categoría III hacia el monte Kholat Syakhl. El grupo tiene experiencia acreditada en condiciones extremas.",
    order: 1,
    created_at: "",
  },
  {
    id: "tl2",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "Última entrada registrada en los diarios",
    description:
      "Zinaida Kolmogorova escribe la última entrada conocida. El grupo reporta condiciones favorables y buen estado de ánimo. Es la última comunicación verificada con el exterior.",
    order: 2,
    created_at: "",
  },
  {
    id: "tl3",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "Noche del incidente",
    description:
      "Algo obliga al grupo a rasgar la tienda desde el interior y huir hacia el bosque en estado de pánico. La temperatura exterior ronda los –30°C. Ninguno lleva calzado. Ninguno regresa.",
    order: 3,
    created_at: "",
  },
  {
    id: "tl4",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "Los rescatistas hallan el campamento vacío",
    description:
      "Una patrulla de búsqueda localiza la tienda rasgada desde adentro. Los primeros cinco cuerpos son encontrados a cientos de metros del campamento en dirección al bosque, en diferentes estados.",
    order: 4,
    created_at: "",
  },
  {
    id: "tl5",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "Cuatro cuerpos recuperados bajo la nieve",
    description:
      "Con el deshielo, se localizan los cuatro cuerpos restantes en un barranco. Las heridas forenses resultan inexplicables. Las prendas presentan radiación. El cuerpo de Dubinina carece de partes blandas del rostro.",
    order: 5,
    created_at: "",
  },
  {
    id: "tl6",
    mystery_id: "dyatlov-pass-1959",
    year: 1959,
    title: "Investigación archivada oficialmente",
    description:
      "La Fiscalía de Sverdlovsk cierra el caso. Causa oficial: «fuerza natural irresistible». Los expedientes son clasificados y entregados al KGB. El acceso al Paso Dyatlov queda prohibido durante tres años.",
    order: 6,
    created_at: "",
  },
  {
    id: "tl7",
    mystery_id: "dyatlov-pass-1959",
    year: 1990,
    title: "Los archivos se abren al público",
    description:
      "El gobierno ruso desclasifica parte de los documentos. Los investigadores descubren que páginas completas de los expedientes forenses han desaparecido. El caso es reabierto informalmente por el Fondo Dyatlov. Permanece sin resolver.",
    order: 7,
    created_at: "",
  },
];

const THEORIES: Theory[] = [
  {
    id: "th1",
    mystery_id: "dyatlov-pass-1959",
    title: "Prueba militar — Arma de onda de presión",
    description:
      "La región era zona de pruebas militares soviéticas activas. Las fracturas óseas sin traumatismo externo son consistentes con una onda de presión de alto impacto. La radiación en las prendas y la prohibición posterior de acceso al área refuerzan esta hipótesis. Testimonios de habitantes locales describen «esferas luminosas naranjas» sobre el cielo la noche del incidente.",
    credibility_score: 78,
    source_url: "Ref. KGB-1959-04-073",
    created_at: "",
  },
  {
    id: "th2",
    mystery_id: "dyatlov-pass-1959",
    title: "Avalancha de placa de nieve",
    description:
      "La teoría oficial revisada en 2019 sugiere una avalancha de placa en la ladera. Sin embargo, la pendiente del terreno es insuficiente para generar el impacto observado. La ausencia de nieve sobre los cuerpos más cercanos al campamento la contradice directamente.",
    credibility_score: 45,
    source_url: "Fiscalía Sverdlovsk — Revisión 2019",
    created_at: "",
  },
  {
    id: "th3",
    mystery_id: "dyatlov-pass-1959",
    title: "Infrasound — Resonancia de viento montañoso",
    description:
      "Frecuencias de infrasound generadas por el viento al superar el relieve montañoso pueden inducir pánico extremo, desorientación severa y alucinaciones. Explicaría la huida irracional, pero no las mutilaciones ni los niveles de radiación en las prendas.",
    credibility_score: 35,
    source_url: "Journal of Acoustic Science, 2013",
    created_at: "",
  },
  {
    id: "th4",
    mystery_id: "dyatlov-pass-1959",
    title: "Intervención de origen desconocido",
    description:
      "Múltiples testigos en pueblos cercanos reportaron luces anaranjadas en el cielo durante las fechas del incidente. Los Mansi denominan al Kholat Syakhl «la montaña de los nueve muertos» — topónimo que precede al incidente de 1959 por décadas.",
    credibility_score: 12,
    source_url: "Testimonio Mansi — Archivo Sverdlovsk 1959",
    created_at: "",
  },
];

const SOURCES: Source[] = [
  {
    id: "s1",
    mystery_id: "dyatlov-pass-1959",
    title: "Archivo Nacional URSS — Ref. KGB-1959-04-073",
    url: "",
    type: "archive",
    year: 1959,
    created_at: "",
  },
  {
    id: "s2",
    mystery_id: "dyatlov-pass-1959",
    title: "Informe forense — Dr. Boris Vozrozhdenny, Sverdlovsk",
    url: "",
    type: "forensic",
    year: 1959,
    created_at: "",
  },
  {
    id: "s3",
    mystery_id: "dyatlov-pass-1959",
    title:
      "Diarios personales de los excursionistas — Digitalización 2013, Fondo Dyatlov",
    url: "",
    type: "primary",
    year: 2013,
    created_at: "",
  },
  {
    id: "s4",
    mystery_id: "dyatlov-pass-1959",
    title: "Informe final Fiscalía Sverdlovsk — Ref. 171959",
    url: "",
    type: "legal",
    year: 1959,
    created_at: "",
  },
  {
    id: "s5",
    mystery_id: "dyatlov-pass-1959",
    title: "Testimonio rescatistas — Coronel Ortiyukow",
    url: "",
    type: "testimony",
    year: 1959,
    created_at: "",
  },
];

const RELATED: Mystery[] = [
  {
    id: "mh370",
    slug: "vuelo-mh370",
    title: "Vuelo MH370",
    summary: "",
    description: "",
    status: "published",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 2014,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "cat1",
    country_id: "my",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "admin",
    country: {
      id: "my",
      name: "Malasia",
      code: "MY",
      flag_emoji: "🇲🇾",
      continent: "Asia",
      created_at: "",
    },
  },
  {
    id: "mk-ultra",
    slug: "proyecto-mk-ultra",
    title: "Proyecto MK-Ultra",
    summary: "",
    description: "",
    status: "published",
    classification_level: "classified",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1953,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "cat2",
    country_id: "us",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "admin",
    country: {
      id: "us",
      name: "EEUU",
      code: "US",
      flag_emoji: "🇺🇸",
      continent: "America",
      created_at: "",
    },
  },
  {
    id: "voynich",
    slug: "manuscrito-voynich",
    title: "El Manuscrito Voynich",
    summary: "",
    description: "",
    status: "archived",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1400,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "cat3",
    country_id: "it",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "admin",
    country: {
      id: "it",
      name: "Italia",
      code: "IT",
      flag_emoji: "🇮🇹",
      continent: "Europe",
      created_at: "",
    },
  },
];

const HECHOS = [
  "La tienda fue rasgada desde el interior por los propios excursionistas, lo que indica una huida en pánico ante una amenaza inmediata e identificada.",
  "Las víctimas abandonaron el campamento descalzas a una temperatura estimada de –30°C, excluyendo cualquier decisión racional o planificada.",
  "Tres cuerpos presentaban fracturas óseas en costillas y cráneo compatibles con impacto de alta energía; la piel, sin embargo, permanecía intacta en todos los casos.",
  "El cadáver de Lyudmila Dubinina carecía de lengua, ojos y parte del labio superior. El forense no pudo determinar el mecanismo ni la causa de esta mutilación.",
  "Varias prendas de los excursionistas registraron niveles de radiación beta y gamma significativamente elevados según el análisis forense de mayo de 1959.",
  "La investigación fue archivada en mayo de 1959 bajo la causa oficial de «fuerza natural desconocida». No se realizaron cargos ni abrió ningún procedimiento paralelo.",
  "Los archivos completos del KGB sobre el incidente permanecieron clasificados hasta 1990 — treinta y un años después de los hechos.",
];

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
  <div>
    <MysteryHero :mystery="MYSTERY" />

    <main id="expediente" class="page-content">
      <div class="two-col">
        <!-- LEFT COLUMN -->
        <div class="col-main">
          <!-- Editorial summary -->
          <section
            class="editorial-summary reveal"
            aria-label="Resumen editorial"
          >
            <p>
              En la noche del 1 de febrero de 1959, nueve experimentados
              excursionistas soviéticos ascendían el monte Kholat Syakhl en los
              Urales del Norte. A una temperatura de cuarenta grados bajo cero,
              algo les obligó a rasgar su tienda desde el interior y huir
              descalzos hacia la oscuridad. Ninguno sobrevivió.
            </p>
            <p>
              Los cuerpos fueron hallados en posiciones que desafían toda
              explicación racional. Algunos presentaban fracturas óseas de una
              violencia equivalente a un accidente de tráfico a alta velocidad,
              pero sin marcas externas en la piel. La lengua, los ojos y parte
              del tejido facial de una de las víctimas habían desaparecido. Sus
              ropas registraron niveles de radiación anómalos.
            </p>
            <p>
              El fiscal de Sverdlovsk archivó el caso bajo la designación
              oficial de «fuerza natural desconocida». Los documentos
              permanecieron clasificados hasta 1990. Hoy, sesenta y cinco años
              después, no existe una explicación consensuada. El expediente
              sigue abierto.
            </p>
          </section>

          <!-- Hechos conocidos -->
          <section class="hechos reveal" aria-label="Hechos conocidos">
            <SectionLabel label="// 02 — HECHOS CONOCIDOS" />
            <div v-for="(hecho, i) in HECHOS" :key="i" class="hecho-item">
              <span class="hecho-num" aria-hidden="true">{{
                String(i + 1).padStart(2, "0")
              }}</span>
              <span class="hecho-chevron" aria-hidden="true">›</span>
              <span class="hecho-text">{{ hecho }}</span>
            </div>
          </section>

          <!-- Timeline -->
          <MysteryTimeline :events="TIMELINE" />

          <!-- Theories -->
          <MysteryTheories :theories="THEORIES" />
        </div>
        <!-- end col-main -->

        <!-- RIGHT COLUMN — sidebar -->
        <aside class="col-sidebar" aria-label="Datos del expediente">
          <DossierSidebar
            :mystery="MYSTERY"
            :sources="SOURCES"
            location-name="Paso Dyatlov, Urales del Norte"
            victims="9 CONFIRMADAS"
            classified-period="KGB 1959 – 1990"
          />
          <MapPlaceholder
            location-name="Paso Dyatlov"
            coords-display="61°45'N · 59°27'E"
          />
          <MysteryRelated :mysteries="RELATED" />
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
