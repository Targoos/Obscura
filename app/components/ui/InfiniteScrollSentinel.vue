<script setup lang="ts">
const emit = defineEmits<{
  intersect: [];
}>();

const sentinel = ref<HTMLElement | null>(null);

const { stop } = useIntersectionObserver(sentinel, ([entry]) => {
  if (entry?.isIntersecting) emit("intersect");
});

onBeforeUnmount(stop);
</script>

<template>
  <div ref="sentinel" aria-hidden="true" class="h-1" />
</template>
