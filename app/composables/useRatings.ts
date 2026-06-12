export function useRatings(_mysteryId: MaybeRef<string>) {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()

  const userRating = ref<number>(0);
  const loading = ref(false);

  async function fetch() {
    // TODO: implement
  }

  async function rate(_score: number) {
    // TODO: implement
  }

  return {
    userRating: readonly(userRating),
    loading: readonly(loading),
    fetch,
    rate,
  };
}
