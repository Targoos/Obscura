import type { Comment } from "~/types/mystery";

export function useComments(_mysteryId: MaybeRef<string>) {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()

  const comments = ref<Comment[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);

  async function fetch() {
    // TODO: implement
  }

  async function submit(_content: string) {
    // TODO: implement — status defaults to 'pending'
  }

  return {
    comments: readonly(comments),
    loading: readonly(loading),
    error: readonly(error),
    fetch,
    submit,
  };
}
