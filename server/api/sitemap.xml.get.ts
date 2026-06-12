export default defineEventHandler(async (event) => {
  setHeader(event, "Content-Type", "application/xml");

  // TODO: query all published mysteries and categories from Supabase
  const mysteries: { slug: string; updated_at: string }[] = [];
  const categories: { slug: string }[] = [];

  const staticRoutes = [
    { url: "/", priority: "1.0", changefreq: "daily" },
    { url: "/explorar", priority: "0.9", changefreq: "daily" },
    { url: "/mapa", priority: "0.7", changefreq: "weekly" },
    { url: "/cronologia", priority: "0.6", changefreq: "weekly" },
  ];

  const config = useRuntimeConfig();
  const baseUrl = config.public.appUrl || "https://obscura.vercel.app";

  const urls = [
    ...staticRoutes.map(
      (r) =>
        `<url><loc>${baseUrl}${r.url}</loc><priority>${r.priority}</priority><changefreq>${r.changefreq}</changefreq></url>`,
    ),
    ...mysteries.map(
      (m) =>
        `<url><loc>${baseUrl}/caso/${m.slug}</loc><lastmod>${m.updated_at}</lastmod><priority>0.8</priority></url>`,
    ),
    ...categories.map(
      (c) =>
        `<url><loc>${baseUrl}/categoria/${c.slug}</loc><priority>0.7</priority></url>`,
    ),
  ];

  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.join("\n")}
</urlset>`;
});
