<script setup lang="ts">
const props = withDefaults(
  defineProps<{
    title?: string;
    subtitle?: string;
    counter?: string;
  }>(),
  {
    title: "EXPLORAR",
    subtitle: "// ARCHIVO — EXPLORADOR DE CASOS",
    counter: "847 EXPEDIENTES ARCHIVADOS",
  },
);

const GLYPHS = "█▓▒░╬╫╪╩╦╣╠═╚╔╝╗▀▄■□▪▫◆◇◈◉○●×+";

const titleEl = ref<HTMLHeadingElement | null>(null);

function decryptTitle(el: HTMLElement, text: string, duration: number) {
  const chars = text.split("");
  const total = chars.length;
  const revealed = new Array<boolean>(total).fill(false);
  let start: number | null = null;

  function tick(ts: number) {
    if (start === null) start = ts;
    const progress = Math.min((ts - start) / duration, 1);
    const revealCount = Math.floor(progress * total * 1.3);
    for (let i = 0; i < total; i++) {
      if (!revealed[i] && i < revealCount) revealed[i] = true;
    }
    let html = "";
    chars.forEach((c, i) => {
      if (c === " ") {
        html += " ";
        return;
      }
      html += revealed[i]
        ? c
        : GLYPHS[Math.floor(Math.random() * GLYPHS.length)];
    });
    el.innerHTML = html;
    if (progress < 1) {
      requestAnimationFrame(tick);
    } else {
      el.innerHTML = chars.map((c) => (c === " " ? " " : c)).join("");
      el.classList.add("animate-flicker");
    }
  }
  requestAnimationFrame(tick);
}

onMounted(() => {
  setTimeout(() => {
    if (titleEl.value) decryptTitle(titleEl.value, props.title, 1200);
  }, 600);
});
</script>

<template>
  <section class="explorer-header" :aria-label="props.title.toLowerCase()">
    <div class="eh-bg" aria-hidden="true" />
    <div class="eh-grid" aria-hidden="true" />
    <div class="eh-vignette" aria-hidden="true" />

    <div class="eh-inner">
      <div class="eh-id text-mono-data" aria-hidden="true">
        {{ props.subtitle }}
      </div>
      <h1
        ref="titleEl"
        class="eh-title text-mystery-title"
        :aria-label="props.title"
      >
        {{ props.title }}
      </h1>
      <div class="eh-count text-mono-data" role="status">
        {{ props.counter }}
      </div>
    </div>
  </section>
</template>

<style scoped>
.explorer-header {
  position: relative;
  height: 280px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  margin-top: 64px; /* header height */
}

.eh-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(
      ellipse 100% 80% at 50% -10%,
      rgba(30, 10, 10, 0.7) 0%,
      transparent 60%
    ),
    radial-gradient(
      ellipse 60% 90% at 0% 50%,
      rgba(10, 6, 6, 0.8) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 60% 70% at 100% 40%,
      rgba(14, 8, 8, 0.6) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 90% 80% at 50% 80%,
      rgba(8, 8, 8, 1) 0%,
      #080808 70%
    );
}

.eh-grid {
  position: absolute;
  inset: 0;
  background:
    linear-gradient(
      90deg,
      transparent 19.9%,
      rgba(255, 255, 255, 0.006) 20%,
      rgba(255, 255, 255, 0.006) 20.1%,
      transparent 20.1%
    ),
    linear-gradient(
      90deg,
      transparent 39.9%,
      rgba(255, 255, 255, 0.004) 40%,
      rgba(255, 255, 255, 0.004) 40.1%,
      transparent 40.1%
    ),
    linear-gradient(
      90deg,
      transparent 59.9%,
      rgba(255, 255, 255, 0.004) 60%,
      rgba(255, 255, 255, 0.004) 60.1%,
      transparent 60.1%
    ),
    linear-gradient(
      90deg,
      transparent 79.9%,
      rgba(255, 255, 255, 0.006) 80%,
      rgba(255, 255, 255, 0.006) 80.1%,
      transparent 80.1%
    );
  pointer-events: none;
}

.eh-vignette {
  position: absolute;
  inset: 0;
  background:
    linear-gradient(
      to bottom,
      rgba(8, 8, 8, 0.5) 0%,
      transparent 30%,
      transparent 60%,
      #080808 100%
    ),
    radial-gradient(
      ellipse 85% 90% at 50% 50%,
      transparent 30%,
      rgba(8, 8, 8, 0.4) 70%,
      rgba(8, 8, 8, 0.8) 100%
    );
  pointer-events: none;
}

.eh-inner {
  position: relative;
  z-index: 2;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
}

.eh-id {
  font-size: 10px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-muted);
  user-select: none;
}

.eh-title {
  font-size: clamp(64px, 10vw, 120px);
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--color-text);
  line-height: 1;
  min-height: 1.1em;
}

.eh-count {
  font-size: 10.5px;
  letter-spacing: 0.25em;
  text-transform: uppercase;
  color: var(--color-muted);
  opacity: 0;
  animation: slideUpFade 0.6s 2.4s forwards;
}

@keyframes slideUpFade {
  from {
    opacity: 0;
    transform: translateY(32px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 768px) {
  .explorer-header {
    height: 240px;
  }

  .eh-title {
    font-size: 64px;
    letter-spacing: 0.08em;
  }
}
</style>
