<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

useHead({ title: "Explorar — Obscura | Archivo de Casos" });

const PER_PAGE = 8;

const MOCK_CASES: Mystery[] = [
  {
    id: "OBX-1959-0012",
    slug: "masacre-paso-dyatlov",
    title: "La Masacre del Paso Dyatlov",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "extreme",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1959,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "1",
    country_id: "1",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "1",
      name: "FENÓMENO",
      slug: "fenomeno",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "1",
      name: "RUSIA",
      code: "RU",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1912-0003",
    slug: "manuscrito-voynich",
    title: "El Manuscrito Voynich",
    summary: "",
    description: "",
    status: "archived",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1404,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "2",
    country_id: "2",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "2",
      name: "OCULTISMO",
      slug: "ocultismo",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "2",
      name: "ESPAÑA",
      code: "ES",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1937-0007",
    slug: "desaparicion-amelia-earhart",
    title: "La Desaparición de Amelia Earhart",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1937,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "3",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "3",
      name: "DESAPARICIÓN",
      slug: "desaparicion",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1947-0022",
    slug: "incidente-roswell",
    title: "El Incidente de Roswell",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "classified",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1947,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "4",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "4",
      name: "FENÓMENO",
      slug: "fenomeno",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-2013-0089",
    slug: "caso-elisa-lam",
    title: "El Caso de Elisa Lam",
    summary: "",
    description: "",
    status: "archived",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 2013,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "5",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "5",
      name: "CRIMEN",
      slug: "crimen",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1530-0001",
    slug: "ciudad-perdida-el-dorado",
    title: "La Ciudad Perdida de El Dorado",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1530,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "6",
    country_id: "4",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "6",
      name: "CONSPIRACIÓN",
      slug: "conspiracion",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "4",
      name: "ARGENTINA",
      code: "AR",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1953-0019",
    slug: "experimento-mkultra",
    title: "El Experimento MKUltra",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "classified",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1953,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "6",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "6",
      name: "CONSPIRACIÓN",
      slug: "conspiracion",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1947-0023",
    slug: "documentos-majestic-12",
    title: "Los Documentos de Majestic-12",
    summary: "",
    description: "",
    status: "draft",
    classification_level: "classified",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1947,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "6",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "6",
      name: "CONSPIRACIÓN",
      slug: "conspiracion",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1978-0044",
    slug: "masacre-jonestown",
    title: "La Masacre de Jonestown",
    summary: "",
    description: "",
    status: "archived",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1978,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "2",
    country_id: "3",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "2",
      name: "OCULTISMO",
      slug: "ocultismo",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "3",
      name: "EEUU",
      code: "US",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
  {
    id: "OBX-1977-0031",
    slug: "poltergeist-enfield",
    title: "El Poltergeist de Enfield",
    summary: "",
    description: "",
    status: "archived",
    classification_level: "disturbing",
    image_url: null,
    latitude: null,
    longitude: null,
    year_occurred: 1977,
    views_count: 0,
    rating_avg: 0,
    rating_count: 0,
    category_id: "7",
    country_id: "5",
    created_at: "",
    updated_at: "",
    published_at: null,
    created_by: "",
    category: {
      id: "7",
      name: "PARANORMAL",
      slug: "paranormal",
      description: null,
      icon: null,
      color: null,
      created_at: "",
    },
    country: {
      id: "5",
      name: "REINO UNIDO",
      code: "UK",
      flag_emoji: null,
      continent: null,
      created_at: "",
    },
  },
];

const TOTAL_ARCHIVE = 847;

const { filters } = useFilters();
const searchRef = toRef(filters, "search");
const debouncedSearch = useDebounce(searchRef, 600);

const estado = ref("");
const clasificacion = ref("");
const view = ref<"grid" | "list">("grid");

function getEstadoKey(m: Mystery): string {
  if (m.classification_level === "classified") return "CLASIFICADO";
  if (m.status === "archived") return "ARCHIVADO";
  if (m.status === "published") return "CASO ABIERTO";
  return "SIN RESOLVER";
}

function getClasificacionKey(m: Mystery): string {
  if (m.classification_level === "classified") return "EXTREMO";
  if (m.classification_level === "extreme") return "ALTO";
  return "MEDIO";
}

const filteredCases = computed(() => {
  let result = MOCK_CASES;
  const q = debouncedSearch.value.trim().toLowerCase();
  if (q) result = result.filter((m) => m.title.toLowerCase().includes(q));
  if (filters.category)
    result = result.filter((m) => m.category?.name === filters.category);
  if (filters.country)
    result = result.filter((m) => m.country?.name === filters.country);
  if (estado.value)
    result = result.filter((m) => getEstadoKey(m) === estado.value);
  if (clasificacion.value)
    result = result.filter(
      (m) => getClasificacionKey(m) === clasificacion.value,
    );
  return result;
});

const {
  page,
  total,
  totalPages,
  hasNext,
  hasPrev,
  next,
  prev,
  goTo,
  reset: resetPage,
} = usePagination(PER_PAGE);

watch(
  filteredCases,
  (cases) => {
    resetPage();
    total.value = cases.length;
  },
  { immediate: true },
);

const pagedCases = computed(() => {
  const start = (page.value - 1) * PER_PAGE;
  return filteredCases.value.slice(start, start + PER_PAGE);
});

const sortBy = ref<
  "created_at" | "year_occurred" | "views_count" | "rating_avg"
>("created_at");
const order = ref<"asc" | "desc">("desc");
</script>

<template>
  <div>
    <ExplorerHeader />

    <FiltersBar
      :search="filters.search"
      :category="filters.category"
      :country="filters.country"
      :estado="estado"
      :clasificacion="clasificacion"
      :view="view"
      @update:search="filters.search = $event"
      @update:category="filters.category = $event"
      @update:country="filters.country = $event"
      @update:estado="estado = $event"
      @update:clasificacion="clasificacion = $event"
      @update:view="view = $event"
    />

    <main class="results-area">
      <ResultsHeader
        :showing="filteredCases.length"
        :total="TOTAL_ARCHIVE"
        :sort-by="sortBy"
        :order="order"
        @update:sort-by="sortBy = $event"
        @update:order="order = $event"
      />

      <ResultsList :cases="pagedCases" :view="view" />
    </main>

    <AppPagination
      v-if="totalPages > 1"
      :page="page"
      :total-pages="totalPages"
      :has-prev="hasPrev"
      :has-next="hasNext"
      @prev="prev"
      @next="next"
      @go-to="goTo"
    />
  </div>
</template>

<style scoped>
.results-area {
  padding: 40px 48px 64px;
}

@media (max-width: 768px) {
  .results-area {
    padding: 28px 20px 48px;
  }
}
</style>
