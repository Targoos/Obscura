export function useDebounce<T>(value: Ref<T>, delay = 300) {
  const debounced = ref<T>(value.value) as Ref<T>;

  watch(value, (v) => {
    const timer = setTimeout(() => {
      debounced.value = v;
    }, delay);

    return () => clearTimeout(timer);
  });

  return debounced;
}
