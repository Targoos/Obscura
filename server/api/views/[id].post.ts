import { createHash } from "node:crypto";

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, "id");

  if (!id) {
    throw createError({ statusCode: 400, statusMessage: "Missing mystery id" });
  }

  // Hash the IP to avoid storing PII
  const ip = getRequestIP(event, { xForwardedFor: true }) ?? "unknown";
  const _ipHash = createHash("sha256").update(ip).digest("hex");

  // TODO: upsert mystery_views row, increment mysteries.views_count via DB function

  return { ok: true };
});
