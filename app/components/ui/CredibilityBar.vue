<script setup lang="ts">
const props = defineProps<{ score: number }>();

const containerEl = ref<HTMLElement | null>(null);
const fillEl = ref<HTMLElement | null>(null);

onMounted(() => {
  if (!containerEl.value || !fillEl.value) return;
  const fill = fillEl.value;
  const obs = new IntersectionObserver(
    (entries) => {
      const entry = entries[0];
      if (entry?.isIntersecting) {
        requestAnimationFrame(() => {
          fill.style.width = `${props.score}%`;
        });
        obs.disconnect();
      }
    },
    { threshold: 0.4 },
  );
  obs.observe(containerEl.value);
});
</script>

<template>
  <div
    ref="containerEl"
    class="cred-bar"
    role="progressbar"
    :aria-valuenow="score"
    aria-valuemin="0"
    aria-valuemax="100"
    :aria-label="`Credibilidad: ${score}%`"
  >
    <div ref="fillEl" class="cred-fill" />
  </div>
</template>

<style scoped>
.cred-bar {
  width: 100%;
  height: 2px;
  background: var(--color-border);
  border-radius: 1px;
  margin-bottom: 14px;
  overflow: hidden;
}

.cred-fill {
  height: 100%;
  background: var(--color-accent);
  width: 0;
  transition: width 1.4s ease;
}
</style>
