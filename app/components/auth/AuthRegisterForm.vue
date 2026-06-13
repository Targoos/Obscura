<script setup lang="ts">
interface RegisterPayload {
  username: string;
  email: string;
  password: string;
  confirmPassword: string;
}

const props = withDefaults(
  defineProps<{
    loading?: boolean;
    error?: string;
  }>(),
  { loading: false },
);

const emit = defineEmits<{
  submit: [payload: RegisterPayload];
}>();

const logoEl = ref<HTMLElement | null>(null);
const username = ref("");
const email = ref("");
const password = ref("");
const confirmPassword = ref("");

const usernameError = ref("");
const emailError = ref("");
const passwordError = ref("");
const confirmError = ref("");

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
  usernameError.value = "";
  emailError.value = "";
  passwordError.value = "";
  confirmError.value = "";
  let valid = true;

  if (
    !username.value.trim() ||
    username.value.trim().length < 3 ||
    !/^[a-zA-Z0-9_]+$/.test(username.value.trim())
  ) {
    usernameError.value = "// MÍN. 3 CARACTERES — SOLO ALFANUMÉRICOS Y _";
    valid = false;
  }
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
  if (password.value && confirmPassword.value !== password.value) {
    confirmError.value = "// LOS CÓDIGOS NO COINCIDEN";
    valid = false;
  }
  return valid;
}

function onSubmit() {
  if (!validate()) return;
  emit("submit", {
    username: username.value.trim(),
    email: email.value.trim(),
    password: password.value,
    confirmPassword: confirmPassword.value,
  });
}
</script>

<template>
  <div class="auth-card">
    <div class="brand-area">
      <div ref="logoEl" class="logo" aria-label="OBSCURA">OBSCURA</div>
      <div class="logo-sub">// REGISTRO DE AGENTE</div>
      <div class="stamp">ACCESO CLASIFICADO</div>
    </div>

    <form class="form-container" novalidate @submit.prevent="onSubmit">
      <div v-if="props.error" class="error-banner" role="alert">
        {{ props.error }}
      </div>

      <div class="field-group">
        <label class="field-label" for="reg-username">NOMBRE DE AGENTE</label>
        <input
          id="reg-username"
          v-model="username"
          class="field-input"
          :class="{ 'has-error': usernameError }"
          type="text"
          placeholder="nombre_agente"
          autocomplete="username"
          :disabled="props.loading"
        />
        <span v-if="usernameError" class="field-error" role="alert">{{
          usernameError
        }}</span>
      </div>

      <div class="field-group">
        <label class="field-label" for="reg-email">IDENTIFICADOR</label>
        <input
          id="reg-email"
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
        <label class="field-label" for="reg-password">CÓDIGO DE ACCESO</label>
        <input
          id="reg-password"
          v-model="password"
          class="field-input"
          :class="{ 'has-error': passwordError }"
          type="password"
          placeholder="mín. 8 caracteres"
          autocomplete="new-password"
          :disabled="props.loading"
        />
        <span v-if="passwordError" class="field-error" role="alert">{{
          passwordError
        }}</span>
      </div>

      <div class="field-group">
        <label class="field-label" for="reg-confirm">CONFIRMAR CÓDIGO</label>
        <input
          id="reg-confirm"
          v-model="confirmPassword"
          class="field-input"
          :class="{ 'has-error': confirmError }"
          type="password"
          placeholder="repetir código"
          autocomplete="new-password"
          :disabled="props.loading"
        />
        <span v-if="confirmError" class="field-error" role="alert">{{
          confirmError
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
          props.loading ? "VERIFICANDO..." : "CREAR CREDENCIALES →"
        }}</span>
      </button>
    </form>

    <div class="switch-line">
      ¿Ya tienes acceso?&nbsp;
      <NuxtLink to="/login" class="switch-link">INICIAR SESIÓN →</NuxtLink>
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

  .logo {
    font-size: 18px;
  }
}
</style>
