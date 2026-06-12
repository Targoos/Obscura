import { defineStore } from "pinia";
import type { Mystery } from "~/types/mystery";

export const useMysteriesStore = defineStore("mysteries", () => {
  const list = ref<Mystery[]>([]);
  const current = ref<Mystery | null>(null);
  const caseOfTheDay = ref<Mystery | null>(null);
  const total = ref(0);
  const loading = ref(false);
  const error = ref<string | null>(null);

  function setCurrent(mystery: Mystery | null) {
    current.value = mystery;
  }

  function setList(mysteries: Mystery[], count: number) {
    list.value = mysteries;
    total.value = count;
  }

  return {
    list,
    current,
    caseOfTheDay,
    total,
    loading,
    error,
    setCurrent,
    setList,
  };
});
