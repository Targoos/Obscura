export interface Filters {
  search: string;
  category: string;
  country: string;
  tags: string[];
  sortBy: "created_at" | "views_count" | "rating_avg" | "year_occurred";
  order: "asc" | "desc";
}

const DEFAULT_FILTERS: Filters = {
  search: "",
  category: "",
  country: "",
  tags: [],
  sortBy: "created_at",
  order: "desc",
};

export function useFilters() {
  const filters = reactive<Filters>({ ...DEFAULT_FILTERS });

  function reset() {
    Object.assign(filters, DEFAULT_FILTERS);
  }

  const hasActiveFilters = computed(
    () =>
      filters.search !== "" ||
      filters.category !== "" ||
      filters.country !== "" ||
      filters.tags.length > 0,
  );

  return {
    filters,
    hasActiveFilters,
    reset,
  };
}
