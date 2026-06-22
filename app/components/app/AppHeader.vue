<script setup lang="ts">
const { y } = useWindowScroll();
const isScrolled = computed(() => y.value > 8);

const user = useSupabaseUser();
const isAuthenticated = computed(() => !!user.value);

const { signOut } = useAuth();

async function handleSignOut() {
  await signOut();
  await navigateTo("/login");
}

const mobileNavOpen = ref(false);
const searchBtnEl = ref<HTMLButtonElement | null>(null);

const navLinks = [
  { to: "/explorar", label: "EXPLORAR" },
  { to: "/mapa", label: "MAPA" },
  { to: "/cronologia", label: "CRONOLOGÍA" },
];

useEventListener("keydown", (e: KeyboardEvent) => {
  if ((e.metaKey || e.ctrlKey) && e.key === "k") {
    e.preventDefault();
    searchBtnEl.value?.focus();
  }
});
</script>

<template>
  <header role="banner" :class="['app-header', { scrolled: isScrolled }]">
    <NuxtLink
      to="/"
      class="header-logo animate-flicker text-mystery-title"
      aria-label="Obscura — inicio"
    >
      OBSC<span class="logo-u-wrap"
        >U<span class="logo-dot" aria-hidden="true" /></span
      >RA
    </NuxtLink>

    <nav class="header-nav" aria-label="Navegación principal">
      <NuxtLink
        v-for="link in navLinks"
        :key="link.to"
        :to="link.to"
        class="nav-link"
      >
        {{ link.label }}
      </NuxtLink>
    </nav>

    <div class="header-actions">
      <button
        ref="searchBtnEl"
        type="button"
        class="search-btn text-mono-data"
        aria-label="Buscar (Cmd+K)"
      >
        <svg
          viewBox="0 0 16 16"
          fill="none"
          stroke="currentColor"
          stroke-width="1.4"
          width="14"
          height="14"
          aria-hidden="true"
        >
          <circle cx="7" cy="7" r="4.5" />
          <path d="M10.5 10.5L14 14" stroke-linecap="round" />
        </svg>
        BUSCAR
        <span class="search-kbd" aria-hidden="true">⌘K</span>
      </button>

      <NuxtLink
        v-if="!isAuthenticated"
        to="/login"
        class="login-btn text-mono-data"
      >
        LOGIN
      </NuxtLink>
      <template v-else>
        <NuxtLink to="/perfil" class="login-btn text-mono-data">
          PERFIL
        </NuxtLink>
        <button
          type="button"
          class="logout-btn text-mono-data"
          @click="handleSignOut"
        >
          SALIR
        </button>
      </template>

      <button
        type="button"
        class="hamburger"
        :aria-expanded="mobileNavOpen"
        aria-label="Abrir menú"
        @click="mobileNavOpen = !mobileNavOpen"
      >
        <span /><span /><span />
      </button>
    </div>
  </header>

  <Transition name="mobile-nav">
    <nav
      v-if="mobileNavOpen"
      class="mobile-nav text-mono-data"
      aria-label="Navegación mobile"
    >
      <NuxtLink
        v-for="link in navLinks"
        :key="link.to"
        :to="link.to"
        class="mobile-nav-link"
        @click="mobileNavOpen = false"
      >
        {{ link.label }}
      </NuxtLink>
    </nav>
  </Transition>
</template>

<style scoped>
.app-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 200;
  height: 64px;
  display: flex;
  align-items: center;
  padding: 0 48px;
  background: transparent;
  border-bottom: 1px solid transparent;
  transition:
    background 0.35s ease,
    border-color 0.35s ease,
    backdrop-filter 0.35s ease;
}

.app-header.scrolled {
  background: rgba(15, 15, 15, 0.92);
  border-bottom-color: var(--color-border);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
}

.header-logo {
  font-size: 18px;
  font-weight: 700;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  text-decoration: none;
  display: flex;
  align-items: baseline;
  user-select: none;
  flex-shrink: 0;
}

.logo-u-wrap {
  position: relative;
  display: inline-block;
}

.logo-dot {
  position: absolute;
  top: -5px;
  left: 50%;
  transform: translateX(-50%);
  width: 5px;
  height: 5px;
  background: var(--color-accent);
  border-radius: 50%;
}

.header-nav {
  display: flex;
  align-items: center;
  gap: 40px;
  margin: 0 auto;
}

.nav-link {
  font-family: var(--font-mono);
  font-size: 10.5px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
  text-decoration: none;
  position: relative;
  transition: color 0.2s;
}

.nav-link::after {
  content: "";
  position: absolute;
  bottom: -3px;
  left: 0;
  right: 0;
  height: 1px;
  background: var(--color-accent);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.25s ease;
}

.nav-link:hover {
  color: var(--color-text);
}
.nav-link:hover::after {
  transform: scaleX(1);
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-shrink: 0;
}

.search-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  background: none;
  border: 1px solid var(--color-border);
  color: var(--color-muted);
  font-size: 10px;
  letter-spacing: 0.14em;
  padding: 6px 12px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition:
    border-color 0.2s,
    color 0.2s;
}

.search-btn:hover {
  border-color: var(--color-muted);
  color: var(--color-text);
}

.search-kbd {
  border: 1px solid var(--color-border);
  border-radius: 2px;
  padding: 1px 4px;
  font-size: 9px;
  color: var(--color-border);
}

.login-btn {
  font-size: 10.5px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-text);
  text-decoration: none;
  background: none;
  border: 1px solid var(--color-accent);
  padding: 8px 20px;
  border-radius: var(--radius-sm);
  transition:
    background 0.2s,
    color 0.2s,
    box-shadow 0.2s;
}

.login-btn:hover {
  background: var(--color-accent);
  color: #fff;
  box-shadow: 0 0 20px rgba(204, 0, 0, 0.3);
}

.logout-btn {
  font-size: 10.5px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
  background: none;
  border: 1px solid var(--color-border);
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition:
    border-color 0.2s,
    color 0.2s;
}

.logout-btn:hover {
  border-color: var(--color-muted);
  color: var(--color-text);
}

.hamburger {
  display: none;
  flex-direction: column;
  gap: 5px;
  background: none;
  border: none;
  padding: 6px;
  cursor: pointer;
}

.hamburger span {
  display: block;
  width: 20px;
  height: 1px;
  background: var(--color-text);
}

/* Mobile nav */
.mobile-nav {
  position: fixed;
  top: 64px;
  left: 0;
  right: 0;
  z-index: 199;
  background: rgba(15, 15, 15, 0.98);
  border-bottom: 1px solid var(--color-border);
  padding: 28px 20px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
}

.mobile-nav-link {
  font-size: 13px;
  letter-spacing: 0.2em;
  color: var(--color-muted);
  text-transform: uppercase;
  text-decoration: none;
  transition: color 0.2s;
}

.mobile-nav-link:hover {
  color: var(--color-text);
}

.mobile-nav-enter-active,
.mobile-nav-leave-active {
  transition:
    opacity 0.2s,
    transform 0.2s;
}
.mobile-nav-enter-from,
.mobile-nav-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

@media (max-width: 768px) {
  .app-header {
    padding: 0 20px;
  }
  .header-nav {
    display: none;
  }
  .search-kbd {
    display: none;
  }
  .hamburger {
    display: flex;
  }
}
</style>
