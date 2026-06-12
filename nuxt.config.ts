// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2025-06-01",

  // Register component subdirs without directory-name prefix so that
  // <StatusBadge>, <SectionLabel>, <MysteryHero>, etc. resolve correctly.
  // Without this, Nuxt 4 + @nuxt/ui would prefix ui/ components as <UiXxx>.
  components: [
    { path: "~/components/app", prefix: "" },
    { path: "~/components/mystery", prefix: "" },
    { path: "~/components/ui", prefix: "" },
    { path: "~/components/map", prefix: "" },
    { path: "~/components/admin", prefix: "" },
    { path: "~/components/auth", prefix: "" },
  ],

  // Force dark mode — Obscura has no light theme.
  // Without this, @nuxt/ui defaults to 'system' which falls back to 'light'
  // when OS preference is undetected, injecting a white-background color scheme.
  colorMode: {
    preference: "dark",
    fallback: "dark",
    classSuffix: "",
  },

  modules: [
    "@pinia/nuxt",
    "@nuxt/ui",
    "@nuxt/fonts",
    "@nuxt/image",
    "@vueuse/nuxt",
    // '@nuxtjs/supabase', // TODO: habilitar cuando tengas credenciales
    "@nuxt/eslint",
  ],

  pinia: {
    storesDirs: ["./app/stores/**"],
  },

  css: ["~/assets/css/main.css"],

  runtimeConfig: {
    supabaseServiceRoleKey: "",
    public: {
      appUrl: "",
    },
  },

  fonts: {
    families: [
      { name: "Cinzel", provider: "google", weights: [400, 600, 700] },
      { name: "IBM Plex Sans", provider: "google", weights: [400, 500, 600] },
      { name: "IBM Plex Mono", provider: "google", weights: [400, 500] },
      { name: "Crimson Text", provider: "google", weights: [400, 600] },
    ],
  },

  image: {
    domains: [process.env.NUXT_PUBLIC_SUPABASE_URL ?? ""],
    format: ["webp"],
  },

  // supabase: {
  //   redirect: false,
  // },

  routeRules: {
    "/": { prerender: true },
    "/explorar": { ssr: true },
    "/caso/**": { isr: 86400 },
    "/categoria/**": { isr: 86400 },
    "/mapa": { ssr: false },
    "/admin/**": { ssr: false },
    "/perfil": { ssr: true },
    "/favoritos": { ssr: true },
    "/historial": { ssr: true },
  },

  experimental: {
    viewTransition: true,
  },

  eslint: {
    config: {
      standalone: true,
    },
  },
});
