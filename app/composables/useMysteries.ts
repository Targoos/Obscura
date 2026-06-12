import type { Mystery } from "~/types/mystery";

export function useMysteries() {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()

  const mysteries = ref<Mystery[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);

  async function fetchAll(_params?: {
    category?: string;
    country?: string;
    tags?: string[];
    search?: string;
    sortBy?: "created_at" | "views_count" | "rating_avg" | "year_occurred";
    order?: "asc" | "desc";
    page?: number;
    perPage?: number;
  }) {
    // TODO: implement
  }

  async function fetchBySlug(_slug: string) {
    // TODO: implement
  }

  async function fetchRelated(_mysteryId: string, _categoryId: string) {
    // TODO: implement
  }

  return {
    mysteries: readonly(mysteries),
    loading: readonly(loading),
    error: readonly(error),
    fetchAll,
    fetchBySlug,
    fetchRelated,
  };
}
