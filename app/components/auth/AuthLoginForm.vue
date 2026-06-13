<script setup lang="ts">
interface LoginPayload {
  email: string;
  password: string;
}

const props = withDefaults(
  defineProps<{
    loading?: boolean;
    error?: string;
  }>(),
  { loading: false },
);

const emit = defineEmits<{
  submit: [payload: LoginPayload];
}>();

const logoEl = ref<HTMLElement | null>(null);
const email = ref("");
const password = ref("");
const emailError = ref("");
const passwordError = ref("");

const DECRYPT_GLYPHS = "█▓▒░╬╫╩╦╣╠═╚╗▀▄■□×+@#$%!?~^";

function decryptTitle(el: HTMLElement, totalMs = 1200) {
  const segments: Array<{ type: "space" | "char" | "br"; real?: string }> = [];
  el.childNodes.forEach((node) => {
    if (node.nodeType === Node.TEXT_NODE) {
      (node.textContent ?? "").split("").forEach((c) => {
        segments.push(
          c === " " ? { type: "space" } : { type: "char", real: c },
        );
      });
    } else if ((node as Element).nodeName === "BR") {
      segments.push({ type: "br" });
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
      if (s.type === "br") return "<br>";
      if (s.type === "space") return " ";
      const escaped = (s.real ?? "")
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;");
      return `<span class="dc-c" data-r="${escaped}" data-ci="${ci++}"></span>`;
    })
    .join("");
  el.style.opacity = "1";
  el.style.filter = "none";

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

  setTimeout(() => el.classList.add("flicker-anim"), totalMs + 120);
}

onMounted(() => {
  if (logoEl.value) {
    decryptTitle(logoEl.value, 1000);
    setTimeout(() => {
      if (logoEl.value) {
        logoEl.value.innerHTML =
          'OBSC<span class="logo-u-wrap"><span class="logo-red-dot"></span>U</span>RA';
      }
    }, 1200);
  }
});

function validate(): boolean {
  emailError.value = "";
  passwordError.value = "";
  let valid = true;
  if (
    !email.value.trim() ||
    !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim())
  ) {
    emailError.value = "// IDENTIFICADOR NO VÁLIDO";
    valid = false;
  }
  if (!password.value || password.value.length < 8) {
    passwordError.value = "// CÓDIGO INSUFICIENTE — MÍN. 8 CARACTERES";
    valid = false;
  }
  return valid;
}

function onSubmit() {
  if (!validate()) return;
  emit("submit", { email: email.value.trim(), password: password.value });
}
</script>

<template>
  <div class="auth-card">
    <div class="brand-area">
      <div ref="logoEl" class="logo" aria-label="OBSCURA">OBSCURA</div>
      <div class="logo-sub">// ACCESO AL ARCHIVO</div>
      <div class="stamp">AUTORIZACIÓN REQUERIDA</div>
    </div>

    <form class="form-container" novalidate @submit.prevent="onSubmit">
      <div v-if="props.error" class="error-banner" role="alert">
        {{ props.error }}
      </div>

      <div class="field-group">
        <div class="field-header">
          <label class="field-label" for="login-email">IDENTIFICADOR</label>
        </div>
        <input
          id="login-email"
          v-model="email"
          class="field-input"
          :class="{ 'has-error': emailError }"
          type="email"
          placeholder="agente@obscura.es"
          autocomplete="email"
          :disabled="props.loading"
        />
        <span v-if="emailError" class="field-error" role="alert">{{
          emailError
        }}</span>
      </div>

      <div class="field-group">
        <div class="field-header">
          <label class="field-label" for="login-password"
            >CÓDIGO DE ACCESO</label
          >
          <NuxtLink to="/recuperar-contrasena" class="field-link"
            >OLVIDÉ MI CÓDIGO →</NuxtLink
          >
        </div>
        <input
          id="login-password"
          v-model="password"
          class="field-input"
          :class="{ 'has-error': passwordError }"
          type="password"
          placeholder="••••••••••••"
          autocomplete="current-password"
          :disabled="props.loading"
        />
        <span v-if="passwordError" class="field-error" role="alert">{{
          passwordError
        }}</span>
      </div>

      <button
        class="submit-btn"
        :class="{ loading: props.loading }"
        type="submit"
        :disabled="props.loading"
      >
        <span v-if="props.loading" class="spinner" aria-hidden="true" />
        <span>{{
          props.loading ? "VERIFICANDO..." : "SOLICITAR ACCESO →"
        }}</span>
      </button>

      <div class="divider" aria-hidden="true">
        <div class="divider-line" />
        <span class="divider-text">— O ACCEDER CON —</span>
        <div class="divider-line" />
      </div>

      <div class="oauth-row">
        <button
          class="oauth-btn"
          type="button"
          aria-label="Continuar con Google"
        >
          <svg
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
            aria-hidden="true"
          >
            <path
              d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
              fill="#4285F4"
            />
            <path
              d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
              fill="#34A853"
            />
            <path
              d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z"
              fill="#FBBC05"
            />
            <path
              d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
              fill="#EA4335"
            />
          </svg>
          GOOGLE
        </button>
        <button
          class="oauth-btn"
          type="button"
          aria-label="Continuar con GitHub"
        >
          <svg
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
            fill="currentColor"
            aria-hidden="true"
          >
            <path
              d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"
            />
          </svg>
          GITHUB
        </button>
      </div>
    </form>

    <div class="switch-line">
      ¿Aún no tienes acceso?&nbsp;
      <NuxtLink to="/registro" class="switch-link">REGISTRARSE →</NuxtLink>
    </div>

    <div class="bottom-stamp">
      CLASIFICADO — ACCESO RESTRINGIDO — USO INTERNO
    </div>
  </div>
</template>

<style scoped>
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

.auth-card {
  width: 100%;
  max-width: 420px;
  display: flex;
  flex-direction: column;
  gap: 28px;
  animation: slideUpFade 0.5s ease forwards;
}

.brand-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
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
  font-weight: 400;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.stamp {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 1.5px solid var(--color-accent);
  padding: 5px 14px;
  display: inline-block;
  transform: rotate(-2deg);
  background: rgba(204, 0, 0, 0.04);
}

.form-container {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  padding: 36px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.error-banner {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 1px solid var(--color-accent);
  padding: 10px 14px;
  background: rgba(204, 0, 0, 0.05);
}

.field-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.field-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.field-label {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.26em;
  text-transform: uppercase;
  color: var(--color-muted);
}

.field-link {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--color-muted);
  text-decoration: none;
  transition: color 0.2s;
}

.field-link:hover {
  color: var(--color-text);
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

.submit-btn:disabled {
  cursor: not-allowed;
  opacity: 0.7;
}

.submit-btn.loading {
  border-color: var(--color-muted);
  color: var(--color-muted);
}

.spinner {
  width: 14px;
  height: 14px;
  border: 2px solid rgba(204, 0, 0, 0.3);
  border-top-color: var(--color-accent);
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
  flex-shrink: 0;
}

.divider {
  display: flex;
  align-items: center;
  gap: 14px;
}

.divider-line {
  flex: 1;
  height: 1px;
  background: var(--color-border);
}

.divider-text {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
  white-space: nowrap;
}

.oauth-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.oauth-btn {
  height: 40px;
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  color: var(--color-text);
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.14em;
  cursor: pointer;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition:
    border-color 0.2s,
    color 0.2s;
}

.oauth-btn:hover {
  border-color: var(--color-muted);
  color: #fff;
}

.oauth-btn svg {
  width: 15px;
  height: 15px;
  flex-shrink: 0;
}

.switch-line {
  text-align: center;
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.14em;
  color: var(--color-muted);
}

.switch-link {
  color: var(--color-accent);
  text-decoration: none;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  transition: color 0.2s;
}

.switch-link:hover {
  color: #ff3333;
}

.bottom-stamp {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.26em;
  text-transform: uppercase;
  color: var(--color-border);
  text-align: center;
}

@media (max-width: 480px) {
  .form-container {
    padding: 24px;
  }

  .oauth-row {
    grid-template-columns: 1fr;
  }

  .logo {
    font-size: 18px;
  }
}
</style>
