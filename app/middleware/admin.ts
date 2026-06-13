export default defineNuxtRouteMiddleware(() => {
  const { user } = useAuth();

  if (!user.value) {
    return navigateTo("/login");
  }

  // TODO: check profile role (editor | admin) via useAuthStore
});
