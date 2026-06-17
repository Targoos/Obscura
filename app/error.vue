<script setup lang="ts">
import type { NuxtError } from "#app";

const props = defineProps<{
  error: NuxtError;
}>();

const errorCode = computed(() =>
  props.error.statusCode === 404 ? "ERR-404" : "ERR-500",
);
const errorTitle = computed(() =>
  props.error.statusCode === 404
    ? "EXPEDIENTE NO ENCONTRADO"
    : "ERROR DEL SISTEMA",
);
const errorSubtitle = computed(() =>
  props.error.statusCode === 404
    ? "El archivo que buscas ha sido clasificado, movido o nunca existió."
    : "Un fallo interno ha comprometido el acceso al archivo. Inténtalo de nuevo.",
);

function goBack() {
  history.back();
}

function goHome() {
  clearError({ redirect: "/" });
}
</script>

<template>
  <div class="error-page">
    <div class="film-grain" aria-hidden="true" />

    <main class="error-main">
      <div class="error-container">
        <div class="error-code">{{ errorCode }}</div>

        <hr class="error-sep" />

        <h1 class="error-title">{{ errorTitle }}</h1>

        <p class="error-subtitle">{{ errorSubtitle }}</p>

        <div class="error-actions">
          <button class="btn-ghost" @click="goBack">← VOLVER AL ARCHIVO</button>
          <button class="btn-ghost" @click="goHome">IR AL INICIO</button>
        </div>

        <div class="error-stamp">ACCESO DENEGADO</div>
      </div>
    </main>
  </div>
</template>

<style>
html,
body {
  background: #080808 !important;
  margin: 0;
  padding: 0;
}
</style>

<style scoped>
@keyframes flicker {
  0%,
  89%,
  91%,
  93%,
  95%,
  97%,
  100% {
    opacity: 1;
  }
  90% {
    opacity: 0.35;
  }
  92% {
    opacity: 0.8;
  }
  94% {
    opacity: 0.3;
  }
  96% {
    opacity: 0.9;
  }
}

@keyframes slideUpFade {
  from {
    opacity: 0;
    transform: translateY(16px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.error-page {
  min-height: 100vh;
  background: #080808;
  display: flex;
  flex-direction: column;
  position: relative;
  color: var(--color-text);
  font-family: var(--font-body);
  -webkit-font-smoothing: antialiased;
}

.film-grain {
  position: fixed;
  inset: 0;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400'%3E%3Cfilter id='g'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='400' height='400' filter='url(%23g)'/%3E%3C/svg%3E");
  opacity: 0.03;
  pointer-events: none;
  z-index: 9999;
}

.error-main {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 64px 24px;
}

.error-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  width: 100%;
  max-width: 600px;
  animation: slideUpFade 0.55s ease forwards;
}

.error-code {
  font-family: var(--font-mono);
  font-size: clamp(64px, 10vw, 120px);
  color: var(--color-accent);
  letter-spacing: 0.12em;
  line-height: 1;
  white-space: nowrap;
  animation: flicker 9s infinite 3s;
}

.error-sep {
  width: 100%;
  max-width: 400px;
  border: none;
  border-top: 1px dashed var(--color-accent-dim);
  margin: 28px auto;
}

.error-title {
  font-family: var(--font-display);
  font-size: clamp(20px, 3vw, 30px);
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--color-text);
  margin: 0 0 16px;
}

.error-subtitle {
  font-family: var(--font-quote);
  font-style: italic;
  font-size: 18px;
  color: var(--color-muted);
  max-width: 420px;
  line-height: 1.6;
  margin: 0 0 40px;
}

.error-actions {
  display: flex;
  gap: 16px;
  align-items: center;
  flex-wrap: wrap;
  justify-content: center;
}

.btn-ghost {
  font-family: var(--font-mono);
  font-size: 12px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 10px 24px;
  appearance: none;
  -webkit-appearance: none;
  background: transparent;
  background-color: transparent;
  border: 1px solid var(--color-accent);
  color: var(--color-text);
  cursor: pointer;
  border-radius: var(--radius-sm);
  transition:
    background-color 0.2s,
    color 0.2s,
    box-shadow 0.2s;
}

.btn-ghost:hover {
  background-color: var(--color-accent);
  color: #fff;
  box-shadow: 0 0 20px rgba(204, 0, 0, 0.35);
}

.error-stamp {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 1.5px solid var(--color-accent);
  padding: 5px 14px;
  display: inline-block;
  transform: rotate(-2deg);
  margin-top: 36px;
  border-radius: 2px;
  background: rgba(204, 0, 0, 0.04);
}

@media (max-width: 480px) {
  .error-actions {
    flex-direction: column;
    width: 100%;
  }

  .btn-ghost {
    width: 100%;
    text-align: center;
  }
}
</style>
