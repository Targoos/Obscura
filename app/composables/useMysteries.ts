import type { Database } from "~/types/supabase";
import type { Mystery, MysteryDetail, Category } from "~/types/mystery";

type SortField = "created_at" | "views_count" | "rating_avg" | "year_occurred";

export interface FetchAllParams {
  category?: string;
  country?: string;
  tags?: string[];
  search?: string;
  status?: "published" | "draft" | "archived";
  sortBy?: SortField;
  order?: "asc" | "desc";
  page?: number;
  perPage?: number;
}

export interface FetchAllResult {
  data: Mystery[];
  count: number;
}

const LIST_SELECT = "*, category:categories(*), country:countries(*)";
const DETAIL_SELECT = `
  *,
  category:categories(*),
  country:countries(*),
  tags:mystery_tags(tag:tags(*)),
  timeline_events(*),
  theories(*),
  sources(*)
`;

export function useMysteries() {
  const supabase = useSupabaseClient<Database>();

  const mysteries = ref<Mystery[]>([]);
  const total = ref(0);
  const loading = ref(false);
  const error = ref<string | null>(null);

  async function fetchAll(
    params: FetchAllParams = {},
  ): Promise<FetchAllResult> {
    const {
      category,
      country,
      tags,
      search,
      status = "published",
      sortBy = "created_at",
      order = "desc",
      page = 1,
      perPage = 12,
    } = params;

    loading.value = true;
    error.value = null;

    let query = supabase
      .from("mysteries")
      .select(LIST_SELECT, { count: "exact" })
      .eq("status", status);

    if (search) query = query.ilike("title", `%${search}%`);
    if (category) query = query.eq("category.slug", category);
    if (country) query = query.eq("country.code", country);
    if (tags && tags.length > 0) {
      query = query.in("mystery_tags.tag_id", tags);
    }

    query = query.order(sortBy, { ascending: order === "asc" });

    const from = (page - 1) * perPage;
    const to = from + perPage - 1;
    query = query.range(from, to);

    const { data, count, error: queryError } = await query;

    loading.value = false;

    if (queryError) {
      error.value = queryError.message;
      mysteries.value = [];
      total.value = 0;
      return { data: [], count: 0 };
    }

    const result = (data ?? []) as unknown as Mystery[];
    mysteries.value = result;
    total.value = count ?? result.length;
    return { data: result, count: total.value };
  }

  async function fetchBySlug(slug: string): Promise<MysteryDetail | null> {
    loading.value = true;
    error.value = null;

    const { data, error: queryError } = await supabase
      .from("mysteries")
      .select(DETAIL_SELECT)
      .eq("slug", slug)
      .single();

    loading.value = false;

    if (queryError) {
      error.value = queryError.message;
      return null;
    }

    return normalizeTags(data) as unknown as MysteryDetail;
  }

  async function fetchRelated(
    mysteryId: string,
    categoryId: string,
    limit = 4,
  ): Promise<Mystery[]> {
    const { data, error: queryError } = await supabase
      .from("mysteries")
      .select(LIST_SELECT)
      .eq("status", "published")
      .eq("category_id", categoryId)
      .neq("id", mysteryId)
      .order("views_count", { ascending: false })
      .limit(limit);

    if (queryError) {
      error.value = queryError.message;
      return [];
    }

    return (data ?? []) as unknown as Mystery[];
  }

  async function fetchFeatured(
    type: "day" | "hero" | "carousel",
  ): Promise<Mystery[]> {
    const { data, error: queryError } = await supabase
      .from("featured_content")
      .select(`position, mystery:mysteries(${LIST_SELECT})`)
      .eq("type", type)
      .eq("active", true)
      .order("position", { ascending: true });

    if (queryError) {
      error.value = queryError.message;
      return [];
    }

    return (data ?? [])
      .map((row) => row.mystery)
      .filter(Boolean) as unknown as Mystery[];
  }

  async function fetchCategories(): Promise<(Category & { count: number })[]> {
    const { data, error: queryError } = await supabase
      .from("categories")
      .select("*, mysteries(count)")
      .order("name", { ascending: true });

    if (queryError) {
      error.value = queryError.message;
      return [];
    }

    return (data ?? []).map((cat) => {
      const raw = cat as unknown as Record<string, unknown>;
      const mysteriesArr = raw.mysteries as
        | Array<{ count: number }>
        | undefined;
      const count =
        Array.isArray(mysteriesArr) && mysteriesArr.length > 0
          ? (mysteriesArr[0]?.count ?? 0)
          : 0;
      return { ...(cat as unknown as Category), count };
    });
  }

  return {
    mysteries,
    total,
    loading,
    error,
    fetchAll,
    fetchBySlug,
    fetchRelated,
    fetchFeatured,
    fetchCategories,
  };
}

// Flatten the nested mystery_tags(tag:tags(*)) shape into a plain tags array.
function normalizeTags(row: Record<string, unknown> | null) {
  if (!row) return row;
  const rawTags = row.tags as Array<{ tag: unknown }> | undefined;
  if (Array.isArray(rawTags)) {
    return { ...row, tags: rawTags.map((t) => t.tag) };
  }
  return row;
}
