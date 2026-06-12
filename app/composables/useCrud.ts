export function useCrud(_resource: string) {
  // TODO: implementar cuando @nuxtjs/supabase esté configurado
  // const supabase = useSupabaseClient()

  const loading = ref(false);
  const error = ref<string | null>(null);

  async function create(_payload: Record<string, unknown>) {
    // TODO: implement
  }

  async function update(_id: string, _payload: Record<string, unknown>) {
    // TODO: implement
  }

  async function remove(_id: string) {
    // TODO: implement
  }

  return {
    loading: readonly(loading),
    error: readonly(error),
    create,
    update,
    remove,
  };
}
