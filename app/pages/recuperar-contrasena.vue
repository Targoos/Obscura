<script setup lang="ts">
definePageMeta({ middleware: ["guest"], layout: "auth" });
useHead({ title: "Recuperar Contraseña — Obscura" });

const logoEl = ref<HTMLElement | null>(null);
const email = ref("");
const emailError = ref("");
const loading = ref(false);
const sent = ref(false);

const DECRYPT_GLYPHS = "█▓▒░╬╫╩╦╣╠═╚╗▀▄■□×+@#$%!?~^";

function decryptTitle(el: HTMLElement, totalMs = 1000) {
  const segments: Array<{ type: "space" | "char"; real?: string }> = [];
  el.childNodes.forEach((node) => {
    if (node.nodeType === Node.TEXT_NODE) {
      (node.textContent ?? "").split("").forEach((c) => {
        segments.push(
          c === " " ? { type: "space" } : { type: "char", real: c },
        );
      });
    }
  });

  const charSegs = segments.filter((s) => s.type === "char");
  const N = charSegs.length;
  if (N === 0) {
    el.style.opacity = "1";
    el.classList.add("flicker-anim");
    return;
  }

  let ci = 0;
  el.innerHTML = segments
    .map((s) => {
      if (s.type === "space") return " ";
      const escaped = (s.real ?? "")
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;");
      return `<span class="dc-c" data-r="${escaped}" data-ci="${ci++}"></span>`;
    })
    .join("");
  el.style.opacity = "1";

  const spans = Array.from(el.querySelectorAll<HTMLElement>(".dc-c"));
  const intervals = spans.map((span) => {
    span.textContent =
      DECRYPT_GLYPHS[Math.floor(Math.random() * DECRYPT_GLYPHS.length)] ?? "";
    return window.setInterval(() => {
      span.textContent =
        DECRYPT_GLYPHS[Math.floor(Math.random() * DECRYPT_GLYPHS.length)] ?? "";
    }, 45);
  });

  spans.forEach((span, i) => {
    const lockAt =
      N === 1 ? totalMs * 0.6 : (i / (N - 1)) * (totalMs - 80) + 80;
    setTimeout(() => {
      clearInterval(intervals[i]);
      span.textContent = span.dataset.r ?? "";
    }, lockAt);
  });

  setTimeout(() => {
    if (logoEl.value) {
      logoEl.value.innerHTML =
        'OBSC<span class="logo-u-wrap"><span class="logo-red-dot"></span>U</span>RA';
      logoEl.value.classList.add("flicker-anim");
    }
  }, totalMs + 120);
}

onMounted(() => {
  if (logoEl.value) {
    decryptTitle(logoEl.value, 1000);
  }
});

function validate(): boolean {
  emailError.value = "";
  if (
    !email.value.trim() ||
    !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim())
  ) {
    emailError.value = "// IDENTIFICADOR INVÁLIDO";
    return false;
  }
  return true;
}

async function onSubmit() {
  if (!validate()) return;
  loading.value = true;
  try {
    // TODO: useAuth().resetPassword(email.value)
    await new Promise((r) => setTimeout(r, 1400));
    sent.value = true;
  } finally {
    loading.value = false;
  }
}
</script>

<template>
  <div class="recover-card">
    <!-- Branding -->
    <div class="brand-area">
      <div ref="logoEl" class="logo" aria-label="OBSCURA">OBSCURA</div>
      <div class="logo-sub">// RECUPERACIÓN DE ACCESO</div>
      <div class="stamp">PROTOCOLO DE EMERGENCIA</div>
    </div>

    <!-- Auth card -->
    <div class="form-card">
      <!-- Step 1: email form -->
      <form
        v-if="!sent"
        class="step-form"
        novalidate
        @submit.prevent="onSubmit"
      >
        <div class="field-group">
          <label class="field-label" for="recover-email"
            >IDENTIFICADOR REGISTRADO</label
          >
          <input
            id="recover-email"
            v-model="email"
            class="field-input"
            :class="{ 'has-error': emailError }"
            type="email"
            placeholder="agente@obscura.red"
            autocomplete="email"
            spellcheck="false"
            :disabled="loading"
            @input="emailError = ''"
            @keydown.enter="onSubmit"
          />
          <span v-if="emailError" class="field-error" role="alert">{{
            emailError
          }}</span>
        </div>

        <button
          class="submit-btn"
          :class="{ loading }"
          type="submit"
          :disabled="loading"
        >
          <span v-if="loading" class="spinner" aria-hidden="true" />
          <span>{{ loading ? "PROCESANDO..." : "ENVIAR PROTOCOLO →" }}</span>
        </button>

        <NuxtLink to="/login" class="back-link">← VOLVER AL ACCESO</NuxtLink>
      </form>

      <!-- Step 2: confirmation -->
      <div v-else class="step-confirm">
        <div class="confirm-icon" aria-hidden="true">
          <svg
            width="20"
            height="20"
            viewBox="0 0 20 20"
            fill="none"
            stroke="currentColor"
            stroke-width="1.8"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <polyline points="3 10 8 15 17 6" />
          </svg>
        </div>
        <div class="confirm-title">PROTOCOLO ENVIADO</div>
        <p class="confirm-text">
          Revisa tu identificador. Las instrucciones expiran en 15 minutos.
        </p>
        <NuxtLink to="/login" class="back-link">← VOLVER AL ACCESO</NuxtLink>
      </div>
    </div>

    <!-- Bottom stamp -->
    <div class="bottom-stamp">
      CLASIFICADO — PROTOCOLO DE EMERGENCIA — USO INTERNO
    </div>
  </div>
</template>

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

@keyframes flickerFast {
  0%,
  94%,
  96%,
  100% {
    opacity: 1;
  }
  95% {
    opacity: 0.1;
  }
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

@keyframes slideUpFade {
  from {
    opacity: 0;
    transform: translateY(14px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.recover-card {
  width: 100%;
  max-width: 420px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 28px;
  animation: slideUpFade 0.5s ease forwards;
  padding: 48px 24px 40px;
}

/* Branding */
.brand-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
  width: 100%;
}

.logo {
  font-family: var(--font-display);
  font-size: 22px;
  font-weight: 700;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  display: flex;
  align-items: baseline;
  user-select: none;
  opacity: 0;
}

.logo.flicker-anim {
  animation: flicker 8s 1s infinite;
}

:deep(.logo-u-wrap) {
  position: relative;
  display: inline-block;
}

:deep(.logo-red-dot) {
  position: absolute;
  top: -5px;
  left: 50%;
  transform: translateX(-50%);
  width: 5px;
  height: 5px;
  background: var(--color-accent);
  border-radius: 50%;
  animation: flickerFast 6s 1.5s infinite;
}

.logo-sub {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.stamp {
  font-family: var(--font-mono);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 1.5px solid var(--color-accent);
  padding: 5px 14px;
  display: inline-block;
  transform: rotate(-2deg);
  border-radius: 2px;
  background: rgba(204, 0, 0, 0.04);
}

/* Form card */
.form-card {
  width: 100%;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  padding: 36px;
}

/* Step 1 */
.step-form {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.field-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.field-label {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.26em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.field-input {
  width: 100%;
  height: 44px;
  background: var(--color-bg);
  border: 1px solid var(--color-border);
  color: var(--color-text);
  font-family: var(--font-mono);
  font-size: 13px;
  padding: 0 14px;
  border-radius: var(--radius-sm);
  caret-color: var(--color-accent);
  outline: none;
  transition:
    border-color 0.2s,
    box-shadow 0.2s;
}

.field-input::placeholder {
  color: var(--color-muted);
  opacity: 0.55;
}

.field-input:focus {
  border-color: var(--color-accent);
  box-shadow: 0 0 0 1px rgba(204, 0, 0, 0.2);
}

.field-input.has-error {
  border-color: var(--color-accent);
}

.field-input:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
  -webkit-box-shadow: 0 0 0 1000px #080808 inset !important;
  -webkit-text-fill-color: #d4d4d4 !important;
  caret-color: #cc0000 !important;
  transition: background-color 5000s ease-in-out 0s;
}

.field-error {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.14em;
  color: var(--color-accent);
  text-transform: uppercase;
}

.submit-btn {
  width: 100%;
  height: 48px;
  background: transparent;
  border: 1px solid var(--color-accent);
  color: var(--color-text);
  font-family: var(--font-mono);
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  cursor: pointer;
  border-radius: var(--radius-sm);
  margin-top: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  transition:
    background 0.2s,
    color 0.2s,
    box-shadow 0.2s,
    border-color 0.2s;
}

.submit-btn:hover:not(:disabled) {
  background: var(--color-accent);
  color: #fff;
  box-shadow: 0 0 20px rgba(204, 0, 0, 0.35);
}

.submit-btn:disabled,
.submit-btn.loading {
  border-color: var(--color-muted);
  color: var(--color-muted);
  cursor: not-allowed;
}

.spinner {
  width: 14px;
  height: 14px;
  border: 1.5px solid rgba(204, 0, 0, 0.3);
  border-top-color: var(--color-accent);
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
  flex-shrink: 0;
}

.back-link {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
  text-decoration: none;
  display: inline-block;
  margin-top: 18px;
  transition: color 0.2s;
}

.back-link:hover {
  color: var(--color-text);
}

/* Step 2 */
.step-confirm {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 0;
  animation: slideUpFade 0.45s ease both;
}

.confirm-icon {
  width: 48px;
  height: 48px;
  border: 1.5px solid var(--color-accent);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--color-accent);
  margin: 0 auto 20px;
}

.confirm-title {
  font-family: var(--font-display);
  font-size: 22px;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--color-text);
  margin-bottom: 14px;
}

.confirm-text {
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.1em;
  color: var(--color-muted);
  line-height: 1.7;
  max-width: 280px;
  margin: 0 auto 22px;
}

/* Bottom stamp */
.bottom-stamp {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.26em;
  text-transform: uppercase;
  color: var(--color-border);
  text-align: center;
  width: 100%;
}

@media (max-width: 480px) {
  .recover-card {
    padding: 36px 16px 32px;
  }

  .form-card {
    padding: 28px 20px;
  }
}
</style>
