<script setup lang="ts">
type Tab = "expedientes" | "historial" | "configuracion";

defineProps<{
  username: string;
  initials: string;
  role: string;
  points: number;
  memberSince: string;
  activeTab: Tab;
  savedCount: number;
  viewedCount: number;
}>();

const emit = defineEmits<{
  "tab-change": [tab: Tab];
}>();
</script>

<template>
  <div class="dossier-header">
    <div class="dossier-header-bg" />
    <div class="dossier-header-grid" />
    <div class="dossier-header-scanlines" />
    <div class="dossier-header-inner">
      <div class="agent-identity">
        <div class="agent-avatar">{{ initials }}</div>
        <div class="agent-info">
          <div class="agent-username">{{ username }}</div>
          <div class="agent-badges">
            <span class="role-badge">{{ role }}</span>
            <span class="agent-points"
              >{{ points.toLocaleString("es-ES") }} PUNTOS</span
            >
          </div>
          <div class="agent-since">AGENTE DESDE {{ memberSince }}</div>
        </div>
      </div>
      <div class="agent-stats">
        <div class="stat-item">
          <div class="stat-label">EXPEDIENTES GUARDADOS</div>
          <div class="stat-value">{{ savedCount }}</div>
        </div>
        <div class="stat-item">
          <div class="stat-label">CASOS CONSULTADOS</div>
          <div class="stat-value">{{ viewedCount }}</div>
        </div>
        <div class="stat-item">
          <div class="stat-label">AGENTE DESDE</div>
          <div class="stat-value stat-value--small">{{ memberSince }}</div>
        </div>
        <div class="stat-item">
          <div class="stat-label">NIVEL DE ACCESO</div>
          <div class="stat-value stat-value--role">{{ role }}</div>
        </div>
      </div>
    </div>
    <div class="tab-bar-wrap">
      <div class="tab-bar-inner">
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'expedientes' }"
          @click="emit('tab-change', 'expedientes')"
        >
          EXPEDIENTES
        </button>
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'historial' }"
          @click="emit('tab-change', 'historial')"
        >
          HISTORIAL
        </button>
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'configuracion' }"
          @click="emit('tab-change', 'configuracion')"
        >
          CONFIGURACIÓN
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* CSS copied from obscura-perfil.html */

.dossier-header {
  position: relative;
  background: var(--color-bg);
  overflow: hidden;
}
.dossier-header-bg {
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    radial-gradient(
      ellipse 60% 100% at 0% 50%,
      rgba(12, 8, 5, 0.9) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 60% 100% at 100% 50%,
      rgba(12, 8, 5, 0.9) 0%,
      transparent 55%
    ),
    radial-gradient(
      ellipse 100% 60% at 50% 0%,
      rgba(20, 14, 8, 0.97) 0%,
      transparent 60%
    );
}
.dossier-header-grid {
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    repeating-linear-gradient(
      90deg,
      transparent 0,
      transparent 79px,
      rgba(255, 255, 255, 0.008) 79px,
      rgba(255, 255, 255, 0.008) 80px
    ),
    repeating-linear-gradient(
      0deg,
      transparent 0,
      transparent 79px,
      rgba(255, 255, 255, 0.008) 79px,
      rgba(255, 255, 255, 0.008) 80px
    );
}
.dossier-header-scanlines {
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(
    to bottom,
    transparent 0px,
    transparent 2px,
    rgba(0, 0, 0, 0.04) 2px,
    rgba(0, 0, 0, 0.04) 4px
  );
}
.dossier-header-inner {
  position: relative;
  z-index: 2;
  max-width: 1440px;
  margin: 0 auto;
  padding: calc(64px + 48px) 48px 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 40px;
}

/* IDENTITY LEFT */
.agent-identity {
  display: flex;
  align-items: center;
  gap: 28px;
}
.agent-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  border: 1px solid var(--color-accent);
  background: var(--color-surface-2);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 26px;
  font-weight: 600;
  color: var(--color-text);
  letter-spacing: 0.04em;
  flex-shrink: 0;
}
.agent-info {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.agent-username {
  font-family: var(--font-display);
  font-size: 32px;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--color-text);
  line-height: 1;
}
.agent-badges {
  display: flex;
  align-items: center;
  gap: 12px;
}
.role-badge {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-classified);
  border: 1px solid var(--color-classified);
  padding: 4px 10px;
  border-radius: 4px;
  background: rgba(255, 102, 0, 0.04);
}
.agent-points {
  font-family: var(--font-mono);
  font-size: 14px;
  letter-spacing: 0.1em;
  color: var(--color-accent);
  font-weight: 500;
}
.agent-since {
  font-family: var(--font-mono);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-muted);
}

/* STATS RIGHT */
.agent-stats {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 28px 40px;
  flex-shrink: 0;
}
.stat-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.stat-label {
  font-family: var(--font-mono);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--color-muted);
}
.stat-value {
  font-family: var(--font-mono);
  font-size: 22px;
  font-weight: 500;
  color: var(--color-text);
  letter-spacing: 0.02em;
}
.stat-value--small {
  font-size: 16px;
  letter-spacing: 0.04em;
}
.stat-value--role {
  font-size: 14px;
  letter-spacing: 0.06em;
  color: var(--color-classified);
}

/* TAB BAR */
.tab-bar-wrap {
  position: relative;
  z-index: 2;
  margin-top: 40px;
  border-top: 1px solid var(--color-border);
  border-bottom: 1px solid var(--color-border);
  background: var(--color-surface);
  overflow-x: auto;
  scrollbar-width: none;
}
.tab-bar-wrap::-webkit-scrollbar {
  display: none;
}
.tab-bar-inner {
  display: flex;
  align-items: stretch;
  max-width: 1440px;
  margin: 0 auto;
  padding: 0 48px;
}
.tab-btn {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--color-muted);
  padding: 16px 28px;
  background: none;
  border: none;
  border-bottom: 2px solid transparent;
  cursor: pointer;
  white-space: nowrap;
  transition:
    color 0.2s,
    border-color 0.2s;
  flex-shrink: 0;
}
.tab-btn:hover {
  color: var(--color-text);
}
.tab-btn.active {
  color: var(--color-text);
  border-bottom-color: var(--color-accent);
}

/* RESPONSIVE */
@media (max-width: 768px) {
  .dossier-header-inner {
    flex-direction: column;
    align-items: flex-start;
    padding: calc(64px + 24px) 20px 0;
    gap: 24px;
  }
  .agent-identity {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }
  .agent-avatar {
    width: 72px;
    height: 72px;
    font-size: 20px;
  }
  .agent-username {
    font-size: 22px;
  }
  .agent-stats {
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    width: 100%;
  }
  .stat-value {
    font-size: 18px;
  }
}
</style>
