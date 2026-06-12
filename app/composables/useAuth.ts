// import type { Provider } from '@supabase/supabase-js'

export function useAuth() {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()
  // const user = useSupabaseUser()
  const user = ref(null); // Mock temporal

  const loading = ref(false);
  const error = ref<string | null>(null);

  async function signIn(email: string, password: string) {
    console.log("signIn mocked", email, password);
  }

  async function signUp(email: string, password: string, username: string) {
    console.log("signUp mocked", email, password, username);
  }

  async function signInWithOAuth(provider: "google" | "github") {
    console.log("signInWithOAuth mocked", provider);
  }

  async function signOut() {
    console.log("signOut mocked");
  }

  async function resetPassword(email: string) {
    console.log("resetPassword mocked", email);
  }

  return {
    user: readonly(user),
    loading: readonly(loading),
    error: readonly(error),
    signIn,
    signUp,
    signInWithOAuth,
    signOut,
    resetPassword,
  };
}
