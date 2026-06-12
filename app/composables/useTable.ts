export function useTable(_resource: string) {
  // TODO: implementar cuando @nuxtjs/supabase esté configurado
  // const supabase = useSupabaseClient()

  const data = ref<Record<string, unknown>[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);
  const page = ref(1);
  const perPage = ref(20);
  const total = ref(0);
  const search = ref("");
  const sort = ref<{ key: string; order: "asc" | "desc" }>({
    key: "created_at",
    order: "desc",
  });

  async function refresh() {
    // TODO: query supabase[resource] with search/sort/pagination
  }

  watch([page, sort, search], () => refresh(), { immediate: true });

  return {
    data: readonly(data),
    loading: readonly(loading),
    error: readonly(error),
    page,
    perPage,
    total: readonly(total),
    search,
    sort,
    refresh,
  };
}
