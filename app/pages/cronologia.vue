<script setup lang="ts">
import type { TimelineEventData } from "~/components/timeline/TimelineEvent.vue";

useHead({ title: "Cronología Global — Obscura" });

const MIN_YEAR = 1500;
const MAX_YEAR = 2024;

const MOCK_EVENTS: TimelineEventData[] = [
  {
    id: "OBX-1561-0001",
    year: 1561,
    title: "La Batalla Aérea de Núremberg",
    status: "archivado",
    categoria: "PARANORMAL",
    country: "🇩🇪 ALEMANIA",
    summary:
      "Cientos de ciudadanos presencian una batalla en el cielo entre objetos luminosos. Grabado en xilografía por Hans Glaser. Ninguna explicación oficial emitida.",
    slug: "batalla-aerea-nuremberg",
  },
  {
    id: "OBX-1692-0002",
    year: 1692,
    title: "Los Juicios de Salem",
    status: "archivado",
    categoria: "CULTO",
    country: "🇺🇸 EEUU",
    summary:
      "Veinte personas ejecutadas tras acusaciones de brujería en Salem, Massachusetts. Los documentos del tribunal revelan irregularidades deliberadas en las pruebas.",
    slug: "juicios-de-salem",
  },
  {
    id: "OBX-1908-0003",
    year: 1908,
    title: "Evento Tunguska",
    status: "archivado",
    categoria: "FENÓMENO",
    country: "🇷🇺 RUSIA",
    summary:
      "Una explosión de 2.000 km² arrasa 80 millones de árboles en Siberia. No se encontró ningún cráter. La causa aún genera debate científico cien años después.",
    slug: "evento-tunguska",
  },
  {
    id: "OBX-1947-0006",
    year: 1947,
    title: "Incidente Roswell",
    status: "clasificado",
    categoria: "PARANORMAL",
    country: "🇺🇸 EEUU",
    summary:
      "Objeto no identificado cae en el Rancho Foster. El ejército confirma un disco volador. Horas después, retracta y declara ser un globo meteorológico de alta altitud.",
    slug: "incidente-roswell",
  },
  {
    id: "OBX-1959-0009",
    year: 1959,
    title: "La Masacre del Paso Dyatlov",
    status: "sin-resolver",
    categoria: "PARANORMAL",
    country: "🇷🇺 RUSIA",
    summary:
      "Nueve excursionistas hallados muertos en circunstancias inexplicables. Las carpas rasgadas desde dentro. Heridas incompatibles con causa natural conocida.",
    slug: "masacre-paso-dyatlov",
  },
  {
    id: "OBX-1969-0012",
    year: 1969,
    title: "Zodiac — El Asesino Sin Rostro",
    status: "sin-resolver",
    categoria: "ASESINATO",
    country: "🇺🇸 EEUU",
    summary:
      "Al menos cinco asesinatos confirmados en el área de la Bahía de San Francisco. Envía cartas cifradas a la prensa. El asesino nunca fue identificado.",
    slug: "zodiac-asesino-sin-rostro",
  },
  {
    id: "OBX-2014-0019",
    year: 2014,
    title: "MH370 — Vuelo Fantasma",
    status: "sin-resolver",
    categoria: "DESAPARICIÓN",
    country: "🇲🇾 MALASIA",
    summary:
      "El Boeing 777 desaparece con 239 personas. Señales de satélite revelan un giro deliberado hacia el sur. El paradero final y el motivo siguen sin conocerse.",
    slug: "mh370-vuelo-fantasma",
  },
  {
    id: "OBX-2023-0020",
    year: 2023,
    title: "Audiencias UAP del Congreso de EEUU",
    status: "abierto",
    categoria: "FENÓMENO",
    country: "🇺🇸 EEUU",
    summary:
      "Ex oficial de inteligencia David Grusch testifica bajo juramento ante el Congreso sobre programas de recuperación de naves no humanas activos y en curso.",
    slug: "audiencias-uap-congreso",
  },
];

const sortAsc = ref(true);
const filterFrom = ref(MIN_YEAR);
const filterTo = ref(MAX_YEAR);

function getCentury(year: number): string {
  if (year < 1800) return "18";
  if (year < 1900) return "19";
  if (year < 2000) return "20";
  return "21";
}

function getDecade(year: number): number {
  return Math.floor(year / 10) * 10;
}

const filteredEvents = computed(() => {
  return [...MOCK_EVENTS]
    .filter((e) => e.year >= filterFrom.value && e.year <= filterTo.value)
    .sort((a, b) => (sortAsc.value ? a.year - b.year : b.year - a.year));
});

interface DecadeGroup {
  decade: number;
  century: string;
  events: TimelineEventData[];
  startIndex: number;
}

const groupedByDecade = computed((): DecadeGroup[] => {
  const map = new Map<number, TimelineEventData[]>();
  for (const ev of filteredEvents.value) {
    const d = getDecade(ev.year);
    if (!map.has(d)) map.set(d, []);
    map.get(d)!.push(ev);
  }
  const keys = [...map.keys()].sort((a, b) =>
    sortAsc.value ? a - b : b - a,
  );
  let idx = 0;
  return keys.map((decade) => {
    const events = map.get(decade)!;
    const startIndex = idx;
    idx += events.length;
    return {
      decade,
      century: getCentury(sortAsc.value ? decade : decade + 9),
      events,
      startIndex,
    };
  });
});

function jumpToCentury(century: string) {
  const el = document.querySelector<HTMLElement>(
    `[data-century="${century}"]`,
  );
  if (!el) return;
  const offsetTop =
    el.getBoundingClientRect().top + window.scrollY - 130;
  window.scrollTo({ top: offsetTop, behavior: "smooth" });
}
</script>

<template>
  <div class="tl-page">
    <ExplorerHeader
      title="CRONOLOGÍA"
      subtitle="// ARCHIVO — LÍNEA TEMPORAL"
      counter="561 CASOS DOCUMENTADOS"
    />

    <TimelineFilters
      :sort-asc="sortAsc"
      :filter-from="filterFrom"
      :filter-to="filterTo"
      :min-year="MIN_YEAR"
      :max-year="MAX_YEAR"
      @update:sort-asc="sortAsc = $event"
      @update:filter-from="filterFrom = $event"
      @update:filter-to="filterTo = $event"
      @jump="jumpToCentury"
    />

    <section class="tl-body" aria-label="Línea temporal de casos">
      <div class="tl-line" aria-hidden="true" />

      <div v-if="groupedByDecade.length > 0">
        <TimelinePeriod
          v-for="group in groupedByDecade"
          :key="group.decade"
          :decade="group.decade"
          :century="group.century"
        >
          <TimelineEvent
            v-for="(event, i) in group.events"
            :key="event.id"
            :event="event"
            :side="(group.startIndex + i) % 2 === 0 ? 'left' : 'right'"
          />
        </TimelinePeriod>
      </div>

      <div v-else class="tl-empty">
        <SectionLabel label="// SIN RESULTADOS" />
        <p class="tl-empty-text">
          Ningún caso registrado en el período seleccionado.
        </p>
      </div>
    </section>
  </div>
</template>

<style scoped>
.tl-page {
  min-height: 100vh;
}

.tl-body {
  max-width: 900px;
  margin: 0 auto;
  padding: 40px 48px 80px;
  position: relative;
}

.tl-line {
  position: absolute;
  left: 50%;
  top: 0;
  bottom: 0;
  width: 0;
  border-left: 1px dashed var(--color-accent);
  opacity: 0.4;
  pointer-events: none;
}

.tl-empty {
  text-align: center;
  padding: 80px 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.tl-empty-text {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--color-muted);
  letter-spacing: 0.12em;
}

@media (max-width: 768px) {
  .tl-body {
    padding: 24px 20px 60px 44px;
  }

  .tl-line {
    left: 20px;
  }
}
</style>
