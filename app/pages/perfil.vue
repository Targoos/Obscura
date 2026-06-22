<script setup lang="ts">
import type { HistoryEntry } from "~/components/profile/ProfileHistoryTable.vue";

useHead({ title: "Mi Perfil — Obscura" });

const activeTab = ref<"expedientes" | "historial" | "configuracion">(
  "expedientes",
);

const mockAgent = {
  username: "AGENTE_OSCURO",
  initials: "AG",
  role: "INVESTIGADOR",
  points: 2847,
  memberSince: "OCT 2023",
  savedCount: 6,
  viewedCount: 34,
};

const mockFavorites = [
  {
    id: "OBX-1959-0012",
    title: "La Masacre del Paso Dyatlov",
    year: 1959,
    country: "🇷🇺 RUSIA",
    category: "FENÓMENOS INEXPLICABLES",
    status: "clasificado" as const,
    imageClass: "card-bg--1",
  },
  {
    id: "OBX-2014-0033",
    title: "Desaparición del Vuelo MH370",
    year: 2014,
    country: "🇲🇾 MALASIA",
    category: "DESAPARICIÓN",
    status: "sin-resolver" as const,
    imageClass: "card-bg--2",
  },
  {
    id: "OBX-1968-0007",
    title: "El Asesino del Zodiaco",
    year: 1968,
    country: "🇺🇸 EE.UU.",
    category: "CRIMEN",
    status: "sin-resolver" as const,
    imageClass: "card-bg--5",
  },
  {
    id: "OBX-1912-0001",
    title: "El Manuscrito Voynich",
    year: 1912,
    country: "🇪🇺 EUROPA",
    category: "OCULTISMO",
    status: "clasificado" as const,
    imageClass: "card-bg--4",
  },
  {
    id: "OBX-1953-0019",
    title: "Experimento MK-Ultra",
    year: 1953,
    country: "🇺🇸 EE.UU.",
    category: "CONSPIRACIÓN",
    status: "archivado" as const,
    imageClass: "card-bg--7",
  },
  {
    id: "OBX-1971-0024",
    title: "Las Caras de Bélmez",
    year: 1971,
    country: "🇪🇸 ESPAÑA",
    category: "PARANORMAL",
    status: "sin-resolver" as const,
    imageClass: "card-bg--6",
  },
];

const mockHistory: HistoryEntry[] = [
  {
    id: "OBX-1959-0012",
    title: "La Masacre del Paso Dyatlov",
    consultedAt: "15 JUN 2026",
    category: "paranormal",
    categoryLabel: "PARANORMAL",
  },
  {
    id: "OBX-2014-0033",
    title: "Desaparición del Vuelo MH370",
    consultedAt: "14 JUN 2026",
    category: "desaparicion",
    categoryLabel: "DESAPARICIÓN",
  },
  {
    id: "OBX-1947-0004",
    title: "Incidente de Roswell",
    consultedAt: "13 JUN 2026",
    category: "paranormal",
    categoryLabel: "PARANORMAL",
  },
  {
    id: "OBX-1968-0007",
    title: "El Asesino del Zodiaco",
    consultedAt: "12 JUN 2026",
    category: "crimen",
    categoryLabel: "CRIMEN",
  },
  {
    id: "OBX-1953-0019",
    title: "Experimento MK-Ultra",
    consultedAt: "11 JUN 2026",
    category: "conspiracion",
    categoryLabel: "CONSPIRACIÓN",
  },
  {
    id: "OBX-1912-0001",
    title: "El Manuscrito Voynich",
    consultedAt: "10 JUN 2026",
    category: "paranormal",
    categoryLabel: "OCULTISMO",
  },
  {
    id: "OBX-1971-0024",
    title: "Las Caras de Bélmez",
    consultedAt: "09 JUN 2026",
    category: "paranormal",
    categoryLabel: "PARANORMAL",
  },
  {
    id: "OBX-2001-0055",
    title: "El Triángulo de las Bermudas",
    consultedAt: "08 JUN 2026",
    category: "desaparicion",
    categoryLabel: "DESAPARICIÓN",
  },
];

const configForm = reactive({
  agentName: "AGENTE_OSCURO",
  identifier: "agente@obscura.es",
  newCode: "",
  confirmCode: "",
});
</script>

<template>
  <div class="perfil-page">
    <AppHeader />

    <ProfileDossierHeader
      :username="mockAgent.username"
      :initials="mockAgent.initials"
      :role="mockAgent.role"
      :points="mockAgent.points"
      :member-since="mockAgent.memberSince"
      :active-tab="activeTab"
      :saved-count="mockAgent.savedCount"
      :viewed-count="mockAgent.viewedCount"
      @tab-change="activeTab = $event"
    />

    <main class="content-area">
      <!-- TAB: EXPEDIENTES -->
      <div v-if="activeTab === 'expedientes'">
        <div class="section-label-row">
          <div class="section-label">// EXPEDIENTES GUARDADOS</div>
        </div>
        <div class="results-count">
          {{ mockFavorites.length }} EXPEDIENTES EN ARCHIVO PERSONAL
        </div>
        <div class="cards-grid">
          <ProfileCard
            v-for="card in mockFavorites"
            :id="card.id"
            :key="card.id"
            :title="card.title"
            :year="card.year"
            :country="card.country"
            :category="card.category"
            :status="card.status"
            :image-class="card.imageClass"
          />
        </div>
      </div>

      <!-- TAB: HISTORIAL -->
      <div v-else-if="activeTab === 'historial'">
        <div class="section-label-row">
          <div class="section-label">// REGISTRO DE CONSULTAS</div>
        </div>
        <div class="results-count">
          {{ mockHistory.length }} CASOS CONSULTADOS RECIENTEMENTE
        </div>
        <ProfileHistoryTable :entries="mockHistory" />
      </div>

      <!-- TAB: CONFIGURACIÓN -->
      <div v-else-if="activeTab === 'configuracion'">
        <div class="section-label-row">
          <div class="section-label">// CONFIGURACIÓN DE AGENTE</div>
        </div>
        <div class="results-count">MODIFICAR CREDENCIALES DE ACCESO</div>
        <div class="config-wrap">
          <form class="config-form" @submit.prevent>
            <div class="field-group">
              <label class="field-label">NOMBRE DE AGENTE</label>
              <input
                v-model="configForm.agentName"
                class="field-input"
                type="text"
              >
            </div>
            <div class="field-group">
              <label class="field-label">IDENTIFICADOR</label>
              <input
                v-model="configForm.identifier"
                class="field-input"
                type="email"
              >
            </div>
            <div class="field-group">
              <label class="field-label">NUEVO CÓDIGO DE ACCESO</label>
              <input
                v-model="configForm.newCode"
                class="field-input"
                type="password"
                placeholder="••••••••••"
              >
            </div>
            <div class="field-group">
              <label class="field-label">CONFIRMAR CÓDIGO</label>
              <input
                v-model="configForm.confirmCode"
                class="field-input"
                type="password"
                placeholder="••••••••••"
              >
            </div>
            <button type="submit" class="save-btn">GUARDAR CAMBIOS →</button>
            <div class="config-divider" />
            <div class="danger-zone-label">// ZONA RESTRINGIDA</div>
            <div class="danger-btns">
              <button type="button" class="danger-btn-outline">
                CERRAR SESIÓN
              </button>
              <div class="danger-link">ELIMINAR CUENTA PERMANENTEMENTE →</div>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.perfil-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: var(--color-bg);
}

/* CONTENT AREA */
.content-area {
  flex: 1;
  max-width: 1440px;
  width: 100%;
  margin: 0 auto;
  padding: 40px 48px 80px;
}

/* SECTION LABEL */
.section-label-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}
.section-label {
  font-family: var(--font-mono);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--color-muted);
  border-left: 3px solid var(--color-accent);
  padding-left: 12px;
}
.results-count {
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--color-muted);
  margin-bottom: 24px;
}

/* CARDS GRID */
.cards-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

/* CONFIG FORM */
.config-wrap {
  max-width: 480px;
  margin: 0 auto;
}
.config-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
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
  border-radius: 4px;
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
.save-btn {
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
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  cursor: pointer;
  transition:
    background 0.2s,
    color 0.2s,
    box-shadow 0.2s;
}
.save-btn:hover {
  background: var(--color-accent);
  color: #fff;
  box-shadow: 0 0 20px rgba(204, 0, 0, 0.3);
}
.config-divider {
  height: 1px;
  background: var(--color-border);
  margin: 8px 0;
}
.danger-zone-label {
  font-family: var(--font-mono);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.32em;
  text-transform: uppercase;
  color: var(--color-muted);
  margin-bottom: 14px;
}
.danger-btns {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.danger-btn-outline {
  width: 100%;
  height: 40px;
  background: transparent;
  border: 1px solid var(--color-border);
  color: var(--color-muted);
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  border-radius: 4px;
  cursor: pointer;
  transition:
    border-color 0.2s,
    color 0.2s;
}
.danger-btn-outline:hover {
  border-color: var(--color-accent);
  color: var(--color-accent);
}
.danger-link {
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--color-accent-dim);
  cursor: pointer;
  text-align: center;
  padding: 8px;
  transition: color 0.2s;
}
.danger-link:hover {
  color: var(--color-accent);
}

/* RESPONSIVE */
@media (max-width: 768px) {
  .content-area {
    padding: 24px 20px 60px;
  }
  .cards-grid {
    grid-template-columns: 1fr;
  }
}
</style>
