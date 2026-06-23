<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

useHead({ title: "Explorar — Obscura | Archivo de Casos" });

const PER_PAGE = 8;

const { fetchAll } = useMysteries();

const { data: allCases } = await useAsyncData(
  "explorar-mysteries",
  async () => {
    const { data } = await fetchAll({ perPage: 1000, status: "published" });
    return data;
  },
  { default: () => [] as Mystery[] },
);

const TOTAL_ARCHIVE = computed(() => allCases.value.length);

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
  let result = allCases.value;
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
