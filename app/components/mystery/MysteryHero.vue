<script setup lang="ts">
import type { Mystery } from "~/types/mystery";

type BadgeVariant = "abierto" | "archivado" | "clasificado" | "sin-resolver";

const props = defineProps<{ mystery: Mystery }>();

const titleEl = ref<HTMLElement | null>(null);

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
  if (titleEl.value) {
    setTimeout(() => decryptTitle(titleEl.value!, 1200), 900);
  }
});

const badgeVariant = computed((): BadgeVariant => {
  if (props.mystery.classification_level === "classified") return "clasificado";
  if (props.mystery.status === "archived") return "archivado";
  if (props.mystery.status === "published") return "abierto";
  return "sin-resolver";
});

const classificationLabel = computed(() => {
  const map: Record<string, string> = {
    disturbing: "PERTURBADOR",
    extreme: "EXTREMO",
    classified: "CLASIFICADO",
  };
  return map[props.mystery.classification_level] ?? "PERTURBADOR";
});

const caseId = computed(() => {
  const year = props.mystery.year_occurred ?? "0000";
  const shortId = props.mystery.id.replace(/-/g, "").slice(0, 4).toUpperCase();
  return `OBX-${year}-${shortId}`;
});

function formatViews(n: number) {
  return n.toLocaleString("es-ES");
}
</script>

<template>
  <section class="hero" :aria-labelledby="`hero-title-${mystery.id}`">
    <div class="hero-bg" aria-hidden="true" />
    <div class="hero-topo" aria-hidden="true" />
    <div class="hero-scanlines" aria-hidden="true" />
    <div class="hero-vignette" aria-hidden="true" />

    <div class="hero-case-id" aria-label="Identificador de caso">
      {{ caseId }}
    </div>

    <div class="hero-status-badge">
      <StatusBadge :variant="badgeVariant" />
    </div>

    <div class="hero-content">
      <span class="hero-classification-label">
        NIVEL DE CLASIFICACIÓN: {{ classificationLabel }}
      </span>
      <h1 :id="`hero-title-${mystery.id}`" ref="titleEl" class="hero-title">
        {{ mystery.title }}
      </h1>
      <p class="hero-subtitle">{{ mystery.summary }}</p>
      <a href="#expediente" class="hero-cta">ABRIR EXPEDIENTE →</a>
    </div>

    <div class="hero-extremo" aria-hidden="true">{{ classificationLabel }}</div>

    <div class="hero-meta-bar" aria-label="Metadatos del caso">
      <div class="meta-item">
        <span class="meta-label">AÑO</span>
        <span class="meta-value">{{ mystery.year_occurred ?? "—" }}</span>
      </div>
      <div v-if="mystery.country" class="meta-item">
        <span class="meta-label">PAÍS</span>
        <span class="meta-value">
          <span aria-hidden="true">{{ mystery.country.flag_emoji }}</span>
          {{ mystery.country.name }}
        </span>
      </div>
      <div v-if="mystery.category" class="meta-item">
        <span class="meta-label">CATEGORÍA</span>
        <span class="meta-value">{{
          mystery.category.name.toUpperCase()
        }}</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">VISTAS</span>
        <span class="meta-value meta-value-accent">{{
          formatViews(mystery.views_count)
        }}</span>
      </div>
      <div class="meta-spacer" aria-hidden="true" />
      <div class="meta-item">
        <span class="meta-label">VALORACIÓN</span>
        <div
          class="meta-stars"
          :aria-label="`Valoración: ${mystery.rating_avg} de 5`"
          aria-hidden="true"
        >
          <span v-for="i in 5" :key="i">{{
            i <= Math.round(mystery.rating_avg) ? "★" : "☆"
          }}</span>
        </div>
        <span class="meta-value">{{ mystery.rating_avg.toFixed(1) }}</span>
      </div>
    </div>
  </section>
</template>

<style scoped>
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes stampReveal {
  from {
    opacity: 0;
    transform: rotate(-4deg) scale(0.8);
  }
  to {
    opacity: 1;
    transform: rotate(-4deg) scale(1);
  }
}

@keyframes badgeIn {
  from {
    opacity: 0;
    transform: scale(0.88);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.hero {
  position: relative;
  height: 100vh;
  min-height: 600px;
  overflow: hidden;
  background-color: #080808;
}

.hero-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(
      ellipse 100% 65% at 50% 0%,
      rgba(18, 13, 9, 0.96) 0%,
      transparent 62%
    ),
    radial-gradient(
      ellipse 50% 100% at 0% 50%,
      rgba(10, 7, 5, 0.9) 0%,
      transparent 50%
    ),
    radial-gradient(
      ellipse 50% 100% at 100% 50%,
      rgba(10, 7, 5, 0.9) 0%,
      transparent 50%
    ),
    radial-gradient(
      ellipse 100% 65% at 50% 100%,
      #080808 0%,
      #080808 55%,
      transparent 100%
    );
}

.hero-topo {
  position: absolute;
  inset: 0;
  background:
    linear-gradient(155deg, rgba(28, 20, 12, 0.18) 0%, transparent 45%),
    radial-gradient(
      ellipse 55% 38% at 22% 35%,
      rgba(35, 25, 14, 0.22) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 45% 42% at 78% 42%,
      rgba(24, 17, 10, 0.18) 0%,
      transparent 55%
    ),
    repeating-linear-gradient(
      90deg,
      transparent 0px,
      transparent 79px,
      rgba(255, 255, 255, 0.003) 79px,
      rgba(255, 255, 255, 0.003) 80px
    ),
    repeating-linear-gradient(
      0deg,
      transparent 0px,
      transparent 79px,
      rgba(255, 255, 255, 0.003) 79px,
      rgba(255, 255, 255, 0.003) 80px
    );
}

.hero-scanlines {
  position: absolute;
  inset: 0;
  background: repeating-linear-gradient(
    to bottom,
    transparent 0px,
    transparent 2px,
    rgba(0, 0, 0, 0.05) 2px,
    rgba(0, 0, 0, 0.05) 4px
  );
  pointer-events: none;
}

.hero-vignette {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(
      ellipse 80% 80% at 50% 50%,
      transparent 20%,
      rgba(8, 8, 8, 0.55) 65%,
      #080808 100%
    ),
    linear-gradient(
      to bottom,
      rgba(8, 8, 8, 0.4) 0%,
      transparent 25%,
      transparent 55%,
      rgba(8, 8, 8, 0.7) 82%,
      #080808 100%
    );
  pointer-events: none;
}

.hero-case-id {
  position: absolute;
  top: calc(64px + 30px);
  left: 48px;
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 400;
  letter-spacing: 0.24em;
  color: var(--color-muted);
  text-transform: uppercase;
  opacity: 0;
  animation: slideUp 0.5s 0.3s forwards;
}

.hero-status-badge {
  position: absolute;
  top: calc(64px + 26px);
  right: 48px;
  opacity: 0;
  animation: badgeIn 0.5s 0.5s forwards;
}

.hero-content {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 128px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 18px;
  padding: 0 80px;
  text-align: center;
  max-width: 1200px;
  margin: 0 auto;
}

.hero-classification-label {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  font-family: var(--font-mono);
  font-size: 9.5px;
  font-weight: 500;
  letter-spacing: 0.36em;
  text-transform: uppercase;
  color: var(--color-classified);
  border: 1px solid rgba(255, 102, 0, 0.45);
  padding: 5px 16px;
  border-radius: var(--radius-sm);
  background: rgba(255, 102, 0, 0.04);
  opacity: 0;
  animation: badgeIn 0.5s 0.9s forwards;
}

.hero-classification-label::before,
.hero-classification-label::after {
  content: "█";
  font-size: 6px;
  opacity: 0.55;
}

.hero-title {
  font-family: var(--font-display);
  font-size: clamp(38px, 5.5vw, 82px);
  font-weight: 700;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: #fff;
  line-height: 1.1;
  max-width: 860px;
  opacity: 0;
}

/* Added by decryptTitle() via JS after animation completes */
.hero-title.flicker-anim {
  animation: flicker 8s 1s infinite;
}

.hero-subtitle {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 18px;
  color: rgba(150, 140, 130, 0.9);
  max-width: 580px;
  line-height: 1.6;
  opacity: 0;
  animation: slideUp 0.7s 3s forwards;
}

.hero-cta {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.25em;
  text-transform: uppercase;
  color: var(--color-text);
  border: 1px solid var(--color-accent);
  padding: 11px 28px;
  border-radius: var(--radius-sm);
  background: transparent;
  text-decoration: none;
  transition:
    background 0.2s,
    color 0.2s,
    box-shadow 0.2s;
  opacity: 0;
  animation: slideUp 0.6s 3.4s forwards;
  margin-top: 4px;
}

.hero-cta:hover {
  background: var(--color-accent);
  color: #fff;
  box-shadow: 0 0 32px rgba(204, 0, 0, 0.35);
}

.hero-extremo {
  position: absolute;
  bottom: 120px;
  left: 48px;
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 2px solid var(--color-accent);
  padding: 6px 14px;
  border-radius: var(--radius-sm);
  transform: rotate(-4deg);
  transform-origin: left center;
  opacity: 0;
  animation: stampReveal 0.6s 1.7s forwards;
  white-space: nowrap;
  user-select: none;
}

.hero-meta-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 64px;
  display: flex;
  align-items: center;
  padding: 0 48px;
  background: rgba(8, 8, 8, 0.88);
  border-top: 1px solid var(--color-border);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  opacity: 0;
  animation: slideUp 0.6s 3.8s forwards;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 0 24px;
  border-right: 1px solid var(--color-border);
  height: 100%;
}

.meta-item:first-child {
  padding-left: 0;
}
.meta-item:last-child {
  border-right: none;
}

.meta-label {
  font-family: var(--font-mono);
  font-size: 9px;
  letter-spacing: 0.22em;
  color: rgba(68, 68, 68, 0.9);
  text-transform: uppercase;
}

.meta-value {
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: var(--color-text);
  letter-spacing: 0.06em;
}

.meta-value-accent {
  color: var(--color-accent);
}

.meta-stars {
  display: flex;
  gap: 3px;
  color: var(--color-warning);
  font-size: 13px;
  letter-spacing: 0;
}

.meta-spacer {
  flex: 1;
}

@media (max-width: 820px) {
  .hero-case-id {
    left: 20px;
  }
  .hero-status-badge {
    right: 20px;
  }
  .hero-content {
    padding: 0 20px;
    bottom: 140px;
  }
  .hero-title {
    font-size: clamp(30px, 8.5vw, 52px);
  }
  .hero-subtitle {
    font-size: 16px;
  }
  .hero-extremo {
    left: 20px;
    bottom: 100px;
    font-size: 9.5px;
  }
  .hero-meta-bar {
    padding: 8px 20px;
    height: auto;
    flex-wrap: wrap;
    gap: 0;
  }
  .meta-item {
    padding: 5px 12px;
    border-right: none;
    border-bottom: 1px solid rgba(31, 31, 31, 0.6);
    height: auto;
    width: 50%;
  }
  .meta-item:last-child,
  .meta-item:nth-last-child(2) {
    border-bottom: none;
  }
  .meta-spacer {
    display: none;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: clamp(26px, 9vw, 42px);
  }
  .hero-cta {
    font-size: 10px;
    padding: 10px 20px;
  }
  .meta-item {
    width: 100%;
  }
}

@media (prefers-reduced-motion: reduce) {
  .hero-case-id,
  .hero-status-badge,
  .hero-classification-label,
  .hero-title,
  .hero-subtitle,
  .hero-cta,
  .hero-meta-bar,
  .hero-extremo {
    opacity: 1;
    animation: none;
  }
}
</style>
