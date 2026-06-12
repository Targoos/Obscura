import { defineStore } from "pinia";
import type { Profile } from "~/types/user";

export const useAuthStore = defineStore("auth", () => {
  const profile = ref<Profile | null>(null);
  const loading = ref(false);

  const isAuthenticated = computed(() => !!profile.value);
  const isAdmin = computed(() => profile.value?.role === "admin");
  const isEditor = computed(
    () => profile.value?.role === "editor" || isAdmin.value,
  );

  async function fetchProfile(_userId: string) {
    // TODO: implement
  }

  function clear() {
    profile.value = null;
  }

  return {
    profile,
    loading,
    isAuthenticated,
    isAdmin,
    isEditor,
    fetchProfile,
    clear,
  };
});
