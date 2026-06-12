<script setup lang="ts">
const props = defineProps<{
  value: number;
  readonly?: boolean;
  max?: number;
}>();

const emit = defineEmits<{
  change: [value: number];
}>();

const maxStars = computed(() => props.max ?? 5);
const hovered = ref(0);
const current = ref(props.value);

watch(
  () => props.value,
  (v) => {
    current.value = v;
  },
);

function setRating(v: number) {
  if (props.readonly) return;
  current.value = v;
  emit("change", v);
}
</script>

<template>
  <div
    class="star-rating"
    :role="readonly ? 'img' : 'group'"
    :aria-label="`Valoración: ${current} de ${maxStars} estrellas`"
  >
    <span
      v-for="star in maxStars"
      :key="star"
      :class="[
        'star',
        { active: star <= (hovered || current), interactive: !readonly },
      ]"
      :title="`${star} ${star === 1 ? 'estrella' : 'estrellas'}`"
      :tabindex="readonly ? -1 : 0"
      role="radio"
      :aria-checked="star <= current"
      @mouseenter="!readonly && (hovered = star)"
      @mouseleave="!readonly && (hovered = 0)"
      @click="setRating(star)"
      @keypress.enter="setRating(star)"
      >★</span
    >
  </div>
</template>

<style scoped>
.star-rating {
  display: flex;
  gap: 3px;
}

.star {
  font-size: 17px;
  color: var(--color-border);
  transition:
    color 0.15s,
    transform 0.15s;
  user-select: none;
  line-height: 1;
}

.star.interactive {
  cursor: pointer;
}

.star.interactive:hover {
  transform: scale(1.3);
}

.star.active {
  color: var(--color-warning);
}
</style>
