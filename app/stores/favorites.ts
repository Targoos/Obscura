import { defineStore } from "pinia";

export const useFavoritesStore = defineStore("favorites", () => {
  const ids = ref<Set<string>>(new Set());

  function add(mysteryId: string) {
    ids.value = new Set([...ids.value, mysteryId]);
  }

  function remove(mysteryId: string) {
    const next = new Set(ids.value);
    next.delete(mysteryId);
    ids.value = next;
  }

  function has(mysteryId: string) {
    return ids.value.has(mysteryId);
  }

  function hydrate(mysteryIds: string[]) {
    ids.value = new Set(mysteryIds);
  }

  return { ids, add, remove, has, hydrate };
});
