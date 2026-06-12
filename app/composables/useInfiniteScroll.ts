export function useInfiniteScroll<T>(fetcher: (page: number) => Promise<T[]>) {
  const items = ref<T[]>([]);
  const page = ref(1);
  const loading = ref(false);
  const hasMore = ref(true);

  async function loadMore() {
    if (loading.value || !hasMore.value) return;

    loading.value = true;
    try {
      const next = await fetcher(page.value);
      if (next.length === 0) {
        hasMore.value = false;
      } else {
        items.value = [...items.value, ...next] as T[];
        page.value++;
      }
    } finally {
      loading.value = false;
    }
  }

  function reset() {
    items.value = [];
    page.value = 1;
    hasMore.value = true;
  }

  return {
    items: readonly(items),
    loading: readonly(loading),
    hasMore: readonly(hasMore),
    loadMore,
    reset,
  };
}
