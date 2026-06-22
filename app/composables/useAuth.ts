import type { Database } from "~/types/supabase";
import type { Profile } from "~/types/user";

export function useAuth() {
  const supabase = useSupabaseClient<Database>();
  const user = useSupabaseUser();

  const loading = ref(false);
  const error = ref<string | null>(null);
  const profile = ref<Profile | null>(null);

  const isAuthenticated = computed(() => !!user.value);

  async function fetchProfile() {
    if (!user.value) {
      profile.value = null;
      return null;
    }

    const { data, error: profileError } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", user.value.id)
      .single();

    if (profileError) {
      error.value = profileError.message;
      return null;
    }

    profile.value = data as Profile;
    return profile.value;
  }

  async function signIn(email: string, password: string) {
    loading.value = true;
    error.value = null;
    try {
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      if (signInError) throw signInError;
      await fetchProfile();
    } catch (err) {
      error.value = (err as Error).message;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  async function signUp(email: string, password: string, username: string) {
    loading.value = true;
    error.value = null;
    try {
      const { error: signUpError } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: { username },
        },
      });
      if (signUpError) throw signUpError;
    } catch (err) {
      error.value = (err as Error).message;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  async function signInWithOAuth(provider: "google" | "github") {
    loading.value = true;
    error.value = null;
    try {
      const redirectTo = import.meta.client
        ? `${window.location.origin}/perfil`
        : undefined;
      const { error: oauthError } = await supabase.auth.signInWithOAuth({
        provider,
        options: { redirectTo },
      });
      if (oauthError) throw oauthError;
    } catch (err) {
      error.value = (err as Error).message;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  async function signOut() {
    loading.value = true;
    error.value = null;
    try {
      const { error: signOutError } = await supabase.auth.signOut();
      if (signOutError) throw signOutError;
      profile.value = null;
    } catch (err) {
      error.value = (err as Error).message;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  async function resetPassword(email: string) {
    loading.value = true;
    error.value = null;
    try {
      const redirectTo = import.meta.client
        ? `${window.location.origin}/recuperar-contrasena`
        : undefined;
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(
        email,
        { redirectTo },
      );
      if (resetError) throw resetError;
    } catch (err) {
      error.value = (err as Error).message;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  return {
    user,
    profile,
    isAuthenticated,
    loading: readonly(loading),
    error: readonly(error),
    fetchProfile,
    signIn,
    signUp,
    signInWithOAuth,
    signOut,
    resetPassword,
  };
}
