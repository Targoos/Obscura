const APP_NAME = "Obscura";
const DEFAULT_OG_IMAGE = "/og-default.jpg";

export function useMetaHead(
  type: "mystery" | "category" | "explore" | "home",
  data?: {
    title?: string;
    summary?: string;
    image_url?: string | null;
    slug?: string;
  },
) {
  const config = useRuntimeConfig();
  const appUrl = config.public.appUrl;

  const titleMap = {
    home: `${APP_NAME} — Algunos archivos no deberían existir.`,
    explore: `Explorar Casos — ${APP_NAME}`,
    category: data?.title ? `${data.title} — ${APP_NAME}` : APP_NAME,
    mystery: data?.title ? `${data.title} — ${APP_NAME}` : APP_NAME,
  };

  const title = titleMap[type];
  const description =
    data?.summary ?? "Documentamos lo que otros prefieren olvidar.";
  const image = data?.image_url ?? DEFAULT_OG_IMAGE;
  const url = data?.slug ? `${appUrl}/caso/${data.slug}` : appUrl;

  useSeoMeta({
    title,
    description,
    ogTitle: title,
    ogDescription: description,
    ogImage: image,
    ogUrl: url,
    twitterCard: "summary_large_image",
    twitterTitle: title,
    twitterImage: image,
  });

  useHead({
    link: [{ rel: "canonical", href: url }],
  });
}
