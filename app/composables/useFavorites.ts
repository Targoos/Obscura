export function useFavorites() {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()
  // const user = useSupabaseUser()
  const _user = ref(null); // Mock temporal

  const favoriteIds = ref<Set<string>>(new Set());
  const loading = ref(false);

  const isFavorite = (mysteryId: string) => favoriteIds.value.has(mysteryId);

  async function fetchFavorites() {
    // TODO: implement
  }

  async function toggle(_mysteryId: string) {
    // TODO: implement
  }

  return {
    favoriteIds: readonly(favoriteIds),
    loading: readonly(loading),
    isFavorite,
    fetchFavorites,
    toggle,
  };
}
