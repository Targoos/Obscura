export function usePagination(perPage = 20) {
  const page = ref(1);
  const total = ref(0);

  const totalPages = computed(() => Math.ceil(total.value / perPage));
  const hasNext = computed(() => page.value < totalPages.value);
  const hasPrev = computed(() => page.value > 1);

  function next() {
    if (hasNext.value) page.value++;
  }

  function prev() {
    if (hasPrev.value) page.value--;
  }

  function goTo(n: number) {
    page.value = Math.max(1, Math.min(n, totalPages.value));
  }

  function reset() {
    page.value = 1;
  }

  return {
    page,
    total,
    perPage,
    totalPages,
    hasNext,
    hasPrev,
    next,
    prev,
    goTo,
    reset,
  };
}
