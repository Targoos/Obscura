export function useAdmin() {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()

  const stats = ref({
    totalMysteries: 0,
    publishedMysteries: 0,
    draftMysteries: 0,
    totalUsers: 0,
    newUsersThisWeek: 0,
    pendingComments: 0,
  });

  const loading = ref(false);

  async function fetchStats() {
    // TODO: implement parallel queries
  }

  return {
    stats: readonly(stats),
    loading: readonly(loading),
    fetchStats,
  };
}
