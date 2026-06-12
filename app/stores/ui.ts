import { defineStore } from "pinia";

export const useUiStore = defineStore("ui", () => {
  const sidebarOpen = ref(false);
  const commandPaletteOpen = ref(false);

  function toggleSidebar() {
    sidebarOpen.value = !sidebarOpen.value;
  }

  function openCommandPalette() {
    commandPaletteOpen.value = true;
  }

  function closeCommandPalette() {
    commandPaletteOpen.value = false;
  }

  return {
    sidebarOpen,
    commandPaletteOpen,
    toggleSidebar,
    openCommandPalette,
    closeCommandPalette,
  };
});
