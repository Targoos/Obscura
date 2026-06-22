import { defineStore } from "pinia";
import type { Database } from "~/types/supabase";
import type { Profile } from "~/types/user";

export const useAuthStore = defineStore("auth", () => {
  const profile = ref<Profile | null>(null);
  const loading = ref(false);
  const error = ref<string | null>(null);

  const isAuthenticated = computed(() => !!profile.value);
  const isAdmin = computed(() => profile.value?.role === "admin");
  const isEditor = computed(
    () => profile.value?.role === "editor" || isAdmin.value,
  );

  async function fetchProfile(userId: string) {
    const supabase = useSupabaseClient<Database>();
    loading.value = true;
    error.value = null;
    try {
      const { data, error: profileError } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .single();

      if (profileError) throw profileError;
      profile.value = data as Profile;
      return profile.value;
    } catch (err) {
      error.value = (err as Error).message;
      profile.value = null;
      return null;
    } finally {
      loading.value = false;
    }
  }

  function clear() {
    profile.value = null;
    error.value = null;
    loading.value = false;
  }

  return {
    profile,
    loading,
    error,
    isAuthenticated,
    isAdmin,
    isEditor,
    fetchProfile,
    clear,
  };
});
