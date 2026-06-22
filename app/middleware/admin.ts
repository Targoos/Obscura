import { useAuthStore } from "~/stores/auth";

export default defineNuxtRouteMiddleware(async () => {
  const user = useSupabaseUser();

  if (!user.value) {
    return navigateTo("/login");
  }

  const authStore = useAuthStore();
  if (!authStore.profile) {
    await authStore.fetchProfile(user.value.id);
  }

  if (!authStore.isEditor) {
    return navigateTo("/");
  }
});
