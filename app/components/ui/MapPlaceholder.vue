<script setup lang="ts">
defineProps<{
  locationName: string;
  coordsDisplay: string;
}>();
</script>

<template>
  <div class="map-card" aria-label="Ubicación del caso en el mapa">
    <div class="map-body">
      <svg
        viewBox="0 0 368 190"
        xmlns="http://www.w3.org/2000/svg"
        aria-hidden="true"
      >
        <defs>
          <radialGradient id="map-ping" cx="55%" cy="48%" r="18%">
            <stop offset="0%" stop-color="#cc0000" stop-opacity="0.4" />
            <stop offset="100%" stop-color="#cc0000" stop-opacity="0" />
          </radialGradient>
        </defs>
        <rect width="368" height="190" fill="#090b0e" />
        <line
          x1="0"
          y1="38"
          x2="368"
          y2="38"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="0"
          y1="76"
          x2="368"
          y2="76"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="0"
          y1="114"
          x2="368"
          y2="114"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="0"
          y1="152"
          x2="368"
          y2="152"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="73.6"
          y1="0"
          x2="73.6"
          y2="190"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="147.2"
          y1="0"
          x2="147.2"
          y2="190"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="220.8"
          y1="0"
          x2="220.8"
          y2="190"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <line
          x1="294.4"
          y1="0"
          x2="294.4"
          y2="190"
          stroke="#151a1e"
          stroke-width="0.7"
        />
        <path
          d="M40,130 Q68,75 100,88 Q132,100 155,52 Q175,22 200,46 Q224,68 255,60 Q282,54 310,72 Q338,88 365,78"
          stroke="#1e2328"
          stroke-width="2"
          fill="none"
        />
        <path
          d="M20,150 Q62,105 105,116 Q140,125 162,82 Q183,55 207,72 Q234,90 266,84 Q295,80 325,96 Q348,108 368,100"
          stroke="#1a1e22"
          stroke-width="1.3"
          fill="none"
        />
        <path
          d="M0,168 Q55,138 108,146 Q148,152 170,110 Q192,78 215,97 Q242,116 272,108 Q308,100 340,118 Q355,126 368,122"
          stroke="#161a1e"
          stroke-width="1"
          fill="none"
        />
        <path
          d="M155,52 L138,88 L172,88 Z"
          fill="#18191c"
          stroke="#212428"
          stroke-width="0.5"
        />
        <path
          d="M200,46 L185,78 L215,78 Z"
          fill="#161819"
          stroke="#1e2024"
          stroke-width="0.5"
        />
        <path
          d="M255,60 L242,90 L268,90 Z"
          fill="#141618"
          stroke="#1c1e22"
          stroke-width="0.5"
        />
        <circle cx="202" cy="82" r="32" fill="url(#map-ping)" />
        <line
          x1="184"
          y1="82"
          x2="220"
          y2="82"
          stroke="#cc0000"
          stroke-width="0.6"
          stroke-dasharray="3,4"
          opacity="0.55"
        />
        <line
          x1="202"
          y1="64"
          x2="202"
          y2="100"
          stroke="#cc0000"
          stroke-width="0.6"
          stroke-dasharray="3,4"
          opacity="0.55"
        />
        <circle cx="202" cy="82" r="6" fill="#cc0000" opacity="0.9" />
        <circle
          cx="202"
          cy="82"
          r="10"
          fill="none"
          stroke="#cc0000"
          stroke-width="1.2"
          opacity="0.45"
        />
        <circle
          cx="202"
          cy="82"
          r="16"
          fill="none"
          stroke="#cc0000"
          stroke-width="0.5"
          opacity="0.25"
        />
        <rect
          x="214"
          y="70"
          width="94"
          height="15"
          fill="#0d0f12"
          rx="2"
          opacity="0.9"
        />
        <text
          x="261"
          y="81"
          font-family="IBM Plex Mono, monospace"
          font-size="7.5"
          fill="#555"
          text-anchor="middle"
          letter-spacing="0.1em"
        >
          {{ locationName.toUpperCase().slice(0, 14) }}
        </text>
        <text
          x="5"
          y="187"
          font-family="IBM Plex Mono, monospace"
          font-size="7"
          fill="#2a2e32"
          letter-spacing="0.08em"
        >
          59°E
        </text>
        <text
          x="5"
          y="12"
          font-family="IBM Plex Mono, monospace"
          font-size="7"
          fill="#2a2e32"
          letter-spacing="0.08em"
        >
          62°N
        </text>
        <text
          x="330"
          y="187"
          font-family="IBM Plex Mono, monospace"
          font-size="7"
          fill="#2a2e32"
          letter-spacing="0.08em"
        >
          60°E
        </text>
      </svg>
    </div>
    <div class="map-footer">
      <span class="map-coords">{{ coordsDisplay }}</span>
      <NuxtLink to="/mapa" class="map-link">ABRIR MAPA ↗</NuxtLink>
    </div>
  </div>
</template>

<style scoped>
.map-card {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.map-body {
  width: 100%;
  height: 190px;
  position: relative;
  overflow: hidden;
  background: #080a0c;
}

.map-body svg {
  width: 100%;
  height: 100%;
}

.map-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 9px 14px;
  background: var(--color-surface);
  border-top: 1px solid var(--color-border);
}

.map-coords {
  font-family: var(--font-mono);
  font-size: 10px;
  color: var(--color-muted);
  letter-spacing: 0.1em;
}

.map-link {
  font-family: var(--font-mono);
  font-size: 9.5px;
  color: var(--color-accent);
  letter-spacing: 0.14em;
  text-transform: uppercase;
  text-decoration: none;
  transition: color 0.2s;
}

.map-link:hover {
  color: var(--color-text);
}
</style>
