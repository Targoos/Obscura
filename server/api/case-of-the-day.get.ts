export default defineEventHandler(async (_event) => {
  // TODO: query featured_content where type='day' and active=true
  // Fallback: pick random published mystery if no featured content active

  return {
    mystery: null,
  };
});
