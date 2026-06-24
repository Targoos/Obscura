<script setup lang="ts">
useHead({ title: "Obscura — Algunos archivos no deberían existir." });

const { fetchFeatured, fetchAll, fetchCategories } = useMysteries();

// ── Real data ─────────────────────────────────────────────────
const { data: dayItems } = await useAsyncData("home-day", () =>
  fetchFeatured("day"),
);
const { data: carouselItems } = await useAsyncData("home-carousel", () =>
  fetchFeatured("carousel"),
);
const { data: latestResult } = await useAsyncData("home-latest", () =>
  fetchAll({ sortBy: "views_count", order: "desc", perPage: 6 }),
);
const { data: categoriesData } = await useAsyncData("home-categories", () =>
  fetchCategories(),
);

const caseOfDay = computed(() => dayItems.value?.[0] ?? null);
const featuredCases = computed(() => carouselItems.value ?? []);
const latestCases = computed(() => latestResult.value?.data ?? []);
const categories = computed(() => categoriesData.value ?? []);

// ── Hero decrypt animation ───────────────────────────────────
const heroTitleEl = ref<HTMLHeadingElement | null>(null);
const GLYPHS = "█▓▒░╬╫╪╩╦╣╠═╚╔╝╗▀▄■□▪▫◆◇◈◉○●×+";

function fadeDecrypt(el: HTMLElement, text: string, duration: number) {
  const source = text.toUpperCase();
  const chars = source.split("");
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
      if (c === "\n") {
        html += "<br>";
        return;
      }
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
      el.innerHTML = chars
        .map((c) => (c === "\n" ? "<br>" : c === " " ? " " : c))
        .join("");
      el.classList.add("animate-flicker");
    }
  }
  requestAnimationFrame(tick);
}

const heroDecryptTitle = computed(() => {
  if (!caseOfDay.value) return "";
  const title = caseOfDay.value.title.toUpperCase();
  const words = title.split(" ");
  const mid = Math.ceil(words.length / 2);
  return words.slice(0, mid).join(" ") + "\n" + words.slice(mid).join(" ");
});

const heroClassificationLabel = computed(() => {
  const level = caseOfDay.value?.classification_level;
  if (level === "classified") return "CLASIFICADO";
  if (level === "extreme") return "EXTREMO";
  if (level === "disturbing") return "PERTURBADOR";
  return "CLASIFICADO";
});

const heroCaseId = computed(() => {
  if (!caseOfDay.value) return "";
  const year = caseOfDay.value.year_occurred ?? new Date().getFullYear();
  const idSuffix = caseOfDay.value.id.slice(-4).toUpperCase();
  return `OBX-${year}-${idSuffix}`;
});

const heroViews = computed(() => {
  const v = caseOfDay.value?.views_count ?? 0;
  return v.toLocaleString("es-ES") + " VISTAS";
});

const heroYear = computed(() => caseOfDay.value?.year_occurred ?? "");
const heroCountry = computed(() => caseOfDay.value?.country ?? null);
const heroCategory = computed(() => caseOfDay.value?.category ?? null);

onMounted(() => {
  setTimeout(() => {
    if (heroTitleEl.value && heroDecryptTitle.value) {
      fadeDecrypt(heroTitleEl.value, heroDecryptTitle.value, 2200);
    }
  }, 1100);

  // Scroll-triggered card reveal
  const revealEls = document.querySelectorAll<Element>(".reveal");
  if ("IntersectionObserver" in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("visible");
            io.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.08, rootMargin: "0px 0px -40px 0px" },
    );
    revealEls.forEach((el) => io.observe(el));
  } else {
    revealEls.forEach((el) => el.classList.add("visible"));
  }
});
</script>

<template>
  <div>
    <!-- § 01 — Caso del Día ─────────────────────────────────── -->
    <section class="hero" aria-label="Caso del día">
      <div class="hero-bg" aria-hidden="true" />
      <div class="hero-env" aria-hidden="true" />
      <div class="hero-scanlines" aria-hidden="true" />
      <div class="hero-vignette" aria-hidden="true" />

      <div class="hero-stamp text-mono-data" aria-label="Caso del día">
        CASO DEL DÍA
      </div>

      <div class="hero-content">
        <div class="hero-badge" role="status">
          {{ heroClassificationLabel }}
        </div>

        <h1
          ref="heroTitleEl"
          class="hero-title text-mystery-title"
          :aria-label="caseOfDay?.title"
        >
          {{ caseOfDay?.title?.toUpperCase() }}
        </h1>

        <p class="hero-subtitle">
          {{ caseOfDay?.summary }}
        </p>

        <NuxtLink
          v-if="caseOfDay"
          :to="`/caso/${caseOfDay.slug}`"
          class="hero-cta text-mono-data"
        >
          ABRIR EXPEDIENTE <span aria-hidden="true">→</span>
        </NuxtLink>
      </div>

      <div class="hero-case-id text-mono-data" aria-hidden="true">
        {{ heroCaseId }}
      </div>

      <div class="hero-meta text-mono-data" role="list">
        <div class="hero-meta-item" role="listitem">{{ heroYear }}</div>
        <div class="hero-meta-sep" aria-hidden="true" />
        <div v-if="heroCountry" class="hero-meta-item" role="listitem">
          <span aria-hidden="true">{{ heroCountry.flag_emoji }}</span>
          {{ heroCountry.name.toUpperCase() }}
        </div>
        <div class="hero-meta-sep" aria-hidden="true" />
        <div v-if="heroCategory" class="hero-meta-item" role="listitem">
          {{ heroCategory.name.toUpperCase() }}
        </div>
        <div class="hero-meta-sep" aria-hidden="true" />
        <div class="hero-meta-item" role="listitem">{{ heroViews }}</div>
      </div>
    </section>

    <!-- § 03 — Casos Destacados ────────────────────────────── -->
    <section class="featured-section" aria-labelledby="sec-destacados">
      <SectionLabel id="sec-destacados" label="// 03 — CASOS DESTACADOS" />
      <div class="featured-scroll" role="list">
        <MysteryCard
          v-for="mystery in featuredCases"
          :key="mystery.id"
          :mystery="mystery"
          class="reveal reveal-stagger featured-card"
          role="listitem"
          tabindex="0"
        />
      </div>
    </section>

    <!-- § 04 — Categorías ──────────────────────────────────── -->
    <section class="categories-section" aria-labelledby="sec-categorias">
      <SectionLabel id="sec-categorias" label="// 04 — CATEGORÍAS" />
      <div class="categories-grid" role="list">
        <NuxtLink
          v-for="cat in categories"
          :key="cat.slug"
          :to="`/explorar?categoria=${cat.slug}`"
          class="cat-pill reveal"
          role="listitem"
        >
          <span class="cat-icon" aria-hidden="true">◈</span>
          <span class="cat-name text-mono-data">{{
            cat.name.toUpperCase()
          }}</span>
          <span class="cat-count text-mono-data">{{ cat.count }}</span>
        </NuxtLink>
      </div>
    </section>

    <!-- § 05 — Últimos Casos ───────────────────────────────── -->
    <section class="latest-section" aria-labelledby="sec-ultimos">
      <SectionLabel id="sec-ultimos" label="// 05 — ÚLTIMOS CASOS" />
      <div class="latest-grid" role="list">
        <MysteryCard
          v-for="mystery in latestCases"
          :key="mystery.id"
          :mystery="mystery"
          class="reveal reveal-stagger"
          role="listitem"
          tabindex="0"
        />
      </div>
      <div class="view-all-wrap">
        <NuxtLink to="/explorar" class="view-all-link text-mono-data">
          VER TODOS LOS CASOS <span class="arrow" aria-hidden="true">→</span>
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

<style scoped>
/* ── Hero ──────────────────────────────────────────────────── */

.hero {
  position: relative;
  height: 100vh;
  min-height: 640px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(
      ellipse 110% 55% at 50% 0%,
      rgba(28, 22, 16, 0.9) 0%,
      transparent 65%
    ),
    radial-gradient(
      ellipse 45% 90% at 0% 50%,
      rgba(12, 10, 8, 0.85) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 55% 70% at 100% 30%,
      rgba(22, 16, 12, 0.7) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 90% 75% at 50% 60%,
      rgba(18, 14, 11, 1) 0%,
      #080808 80%
    );
}

.hero-env {
  position: absolute;
  inset: 0;
  background:
    linear-gradient(
      90deg,
      transparent 19.9%,
      rgba(255, 255, 255, 0.008) 20%,
      rgba(255, 255, 255, 0.008) 20.1%,
      transparent 20.1%
    ),
    linear-gradient(
      90deg,
      transparent 79.9%,
      rgba(255, 255, 255, 0.008) 80%,
      rgba(255, 255, 255, 0.008) 80.1%,
      transparent 80.1%
    ),
    linear-gradient(
      180deg,
      transparent 34.9%,
      rgba(255, 255, 255, 0.005) 35%,
      transparent 35.1%
    ),
    radial-gradient(
      ellipse 30% 40% at 15% 20%,
      rgba(60, 50, 35, 0.12) 0%,
      transparent 60%
    );
}

.hero-scanlines {
  position: absolute;
  inset: 0;
  background: repeating-linear-gradient(
    to bottom,
    transparent 0px,
    transparent 2px,
    rgba(0, 0, 0, 0.04) 2px,
    rgba(0, 0, 0, 0.04) 4px
  );
  pointer-events: none;
  opacity: 0.6;
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
      rgba(8, 8, 8, 0.3) 0%,
      transparent 30%,
      transparent 60%,
      #080808 100%
    );
  pointer-events: none;
}

.hero-stamp {
  position: absolute;
  top: calc(64px + 36px);
  left: 48px;
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-accent);
  border: 1.5px solid var(--color-accent);
  padding: 5px 12px;
  transform: rotate(-3deg);
  transform-origin: left center;
  white-space: nowrap;
  user-select: none;
  animation: stampIn 0.6s 0.4s both;
}

.hero-content {
  position: relative;
  z-index: 2;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  padding: 0 32px;
  max-width: 960px;
  width: 100%;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.35em;
  text-transform: uppercase;
  color: var(--color-classified);
  border: 1px solid rgba(255, 102, 0, 0.5);
  padding: 5px 14px;
  border-radius: var(--radius-sm);
  background: rgba(255, 102, 0, 0.04);
  animation: badgeIn 0.5s 0.9s both;
}

.hero-badge::before,
.hero-badge::after {
  content: "▌";
  font-size: 7px;
  opacity: 0.7;
}

.hero-title {
  font-size: clamp(38px, 6vw, 84px);
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--color-text);
  line-height: 1.08;
  text-shadow:
    0 0 60px rgba(204, 0, 0, 0.12),
    0 0 120px rgba(0, 0, 0, 0.8);
  min-height: 1.5em;
}

.hero-subtitle {
  font-family: var(--font-editorial);
  font-size: clamp(16px, 2vw, 21px);
  font-style: italic;
  color: var(--color-muted);
  max-width: 620px;
  line-height: 1.6;
  animation: slideUpFade 0.7s 2.2s both;
}

.hero-cta {
  margin-top: 6px;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  font-size: 11.5px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-text);
  text-decoration: none;
  background: none;
  border: 1px solid var(--color-accent);
  padding: 14px 36px;
  border-radius: var(--radius-sm);
  transition:
    background 0.25s,
    box-shadow 0.25s;
  animation: slideUpFade 0.7s 2.6s both;
}

.hero-cta:hover {
  background: rgba(204, 0, 0, 0.1);
  box-shadow:
    0 0 24px rgba(204, 0, 0, 0.2),
    inset 0 0 24px rgba(204, 0, 0, 0.04);
}

.hero-case-id {
  position: absolute;
  bottom: 52px;
  left: 48px;
  font-size: 10px;
  letter-spacing: 0.2em;
  color: var(--color-muted);
  text-transform: uppercase;
  animation: slideUpFade 0.6s 1.6s both;
}

.hero-meta {
  position: absolute;
  bottom: 48px;
  left: 0;
  right: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10.5px;
  letter-spacing: 0.15em;
  color: var(--color-muted);
  text-transform: uppercase;
  animation: slideUpFade 0.7s 2s both;
}

.hero-meta-item {
  padding: 0 24px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.hero-meta-sep {
  width: 1px;
  height: 14px;
  background: var(--color-border);
  flex-shrink: 0;
}

/* ── Featured strip ────────────────────────────────────────── */

.featured-section {
  padding: 80px 48px 72px;
  background: var(--color-bg);
  border-top: 1px solid var(--color-border);
}

.featured-scroll {
  display: flex;
  gap: 20px;
  overflow-x: auto;
  padding-bottom: 12px;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: thin;
  scrollbar-color: var(--color-border) transparent;
}

.featured-scroll::-webkit-scrollbar {
  height: 2px;
}
.featured-scroll::-webkit-scrollbar-track {
  background: transparent;
}
.featured-scroll::-webkit-scrollbar-thumb {
  background: var(--color-border);
}

.featured-card {
  width: 300px;
  flex-shrink: 0;
  scroll-snap-align: start;
}

/* ── Categories ────────────────────────────────────────────── */

.categories-section {
  padding: 0 48px 80px;
  background: var(--color-bg);
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 8px;
}

.cat-pill {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 13px 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 9px;
  text-align: left;
  transition:
    border-color 0.2s,
    color 0.2s,
    background 0.2s,
    box-shadow 0.2s;
}

.cat-pill:hover {
  border-color: var(--color-accent);
  background: rgba(204, 0, 0, 0.03);
  box-shadow:
    0 0 0 1px rgba(204, 0, 0, 0.12),
    0 4px 20px rgba(204, 0, 0, 0.08),
    inset 0 0 30px rgba(204, 0, 0, 0.02);
}

.cat-pill:hover .cat-name,
.cat-pill:hover .cat-icon {
  color: var(--color-text);
  opacity: 0.7;
}
.cat-pill:hover .cat-count {
  color: var(--color-accent);
}

.cat-icon {
  font-size: 11px;
  color: var(--color-muted);
  opacity: 0.35;
  flex-shrink: 0;
  transition:
    opacity 0.2s,
    color 0.2s;
}

.cat-name {
  flex: 1;
  font-size: 9.5px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
  line-height: 1.3;
  transition: color 0.2s;
}

.cat-count {
  font-size: 8.5px;
  color: var(--color-border);
  flex-shrink: 0;
  transition: color 0.2s;
}

/* ── Latest cases ──────────────────────────────────────────── */

.latest-section {
  padding: 80px 48px 72px;
  background: var(--color-surface);
  border-top: 1px solid var(--color-border);
}

.latest-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.view-all-wrap {
  margin-top: 44px;
  text-align: center;
}

.view-all-link {
  font-size: 10.5px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-muted);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  border-bottom: 1px solid var(--color-border);
  padding-bottom: 3px;
  transition:
    color 0.2s,
    border-color 0.2s;
}

.view-all-link:hover {
  color: var(--color-text);
  border-bottom-color: var(--color-muted);
}

.arrow {
  transition: transform 0.2s;
}
.view-all-link:hover .arrow {
  transform: translateX(4px);
}

/* ── Hero keyframes ────────────────────────────────────────── */

@keyframes stampIn {
  from {
    opacity: 0;
    transform: rotate(-3deg) scale(0.85);
  }
  to {
    opacity: 1;
    transform: rotate(-3deg) scale(1);
  }
}

@keyframes badgeIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
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

/* ── Responsive ────────────────────────────────────────────── */

@media (max-width: 768px) {
  .hero-stamp {
    top: calc(64px + 20px);
    left: 20px;
    font-size: 9px;
    padding: 4px 10px;
  }
  .hero-case-id {
    left: 20px;
    bottom: 96px;
  }
  .hero-meta {
    flex-wrap: wrap;
    gap: 6px 0;
    bottom: 36px;
    padding: 0 20px;
    font-size: 9.5px;
  }
  .hero-meta-item {
    padding: 0 12px;
  }
  .hero-meta-sep {
    height: 10px;
  }
  .hero-badge {
    font-size: 9px;
    padding: 4px 10px;
  }
  .hero-title {
    font-size: clamp(30px, 8.5vw, 48px);
    letter-spacing: 0.06em;
  }
  .hero-subtitle {
    font-size: 15px;
  }
  .hero-cta {
    font-size: 10px;
    padding: 12px 24px;
    letter-spacing: 0.18em;
  }

  .featured-section,
  .latest-section {
    padding: 52px 20px 48px;
  }
  .categories-section {
    padding: 0 20px 52px;
  }
  .categories-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .latest-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .hero-meta-item:nth-child(n + 6),
  .hero-meta-sep:nth-child(n + 5) {
    display: none;
  }
}
</style>
