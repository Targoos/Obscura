<script setup lang="ts">
const navLinks = [
  { to: "/explorar", label: "EXPLORAR" },
  { to: "/mapa", label: "MAPA" },
  { to: "/cronologia", label: "CRONOLOGÍA" },
  { to: "/acerca", label: "ACERCA" },
];
</script>

<template>
  <footer role="contentinfo">
    <div class="footer-main">
      <div class="footer-brand">
        <div class="footer-logo text-mystery-title animate-flicker">
          OBSCURA
        </div>
        <p class="footer-tagline">Algunos archivos no deberían existir.</p>
      </div>

      <nav class="footer-nav" aria-label="Navegación del pie">
        <NuxtLink
          v-for="link in navLinks"
          :key="link.to"
          :to="link.to"
          class="footer-nav-link text-mono-data"
        >
          {{ link.label }}
        </NuxtLink>
      </nav>

      <div class="footer-stamp text-mono-data" aria-hidden="true">
        CLASIFICADO — USO INTERNO
      </div>
    </div>

    <div class="footer-bottom">
      <span class="text-mono-data footer-copy"
        >© 2024 OBSCURA ARCHIVE PROJECT</span
      >
      <span class="text-mono-data footer-version"
        >SISTEMA v2.4.1 — ACCESO RESTRINGIDO</span
      >
    </div>
  </footer>
</template>

<style scoped>
footer {
  background: var(--color-surface);
}

.footer-main {
  border-top: 1px dashed var(--color-accent);
  padding: 40px 48px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 32px;
}

.footer-brand {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.footer-logo {
  font-size: 15px;
  font-weight: 700;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  user-select: none;
}

.footer-tagline {
  font-family: var(--font-editorial);
  font-size: 13px;
  font-style: italic;
  color: var(--color-muted);
}

.footer-nav {
  display: flex;
  gap: 32px;
  justify-content: center;
  align-items: center;
}

.footer-nav-link {
  font-size: 9.5px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-muted);
  text-decoration: none;
  transition: color 0.2s;
}

.footer-nav-link:hover {
  color: var(--color-text);
}

.footer-stamp {
  font-size: 9.5px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-classified);
  border: 1px solid rgba(255, 102, 0, 0.3);
  padding: 7px 14px;
  border-radius: var(--radius-sm);
  justify-self: end;
  opacity: 0.5;
  user-select: none;
}

.footer-bottom {
  padding: 16px 48px;
  border-top: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.footer-copy,
.footer-version {
  font-size: 9px;
  letter-spacing: 0.14em;
  color: var(--color-border);
  text-transform: uppercase;
}

@media (max-width: 768px) {
  .footer-main {
    grid-template-columns: 1fr;
    gap: 24px;
    padding: 32px 20px;
    text-align: center;
  }

  .footer-nav {
    flex-direction: column;
    gap: 14px;
  }
  .footer-stamp {
    justify-self: center;
  }

  .footer-bottom {
    padding: 14px 20px;
    flex-direction: column;
    gap: 6px;
    text-align: center;
  }
}
</style>
