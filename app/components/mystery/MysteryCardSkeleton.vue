<script setup lang="ts"></script>

<template>
  <div class="card-surface skeleton" aria-hidden="true" aria-busy="true">
    <div class="skeleton-image" />
    <div class="skeleton-body">
      <div class="skeleton-line line-title" />
      <div class="skeleton-line line-title line-short" />
      <div class="skeleton-line line-meta" />
    </div>
  </div>
</template>

<style scoped>
.skeleton {
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.skeleton-image {
  height: 190px;
  background: var(--color-surface-2);
  animation: shimmer 1.6s ease-in-out infinite;
}

.skeleton-body {
  padding: 14px 16px 16px;
  display: flex;
  flex-direction: column;
  gap: 9px;
}

.skeleton-line {
  border-radius: 2px;
  background: var(--color-surface-2);
  animation: shimmer 1.6s ease-in-out infinite;
}

.line-title {
  height: 14px;
  width: 80%;
}
.line-short {
  width: 55%;
  animation-delay: 0.1s;
}
.line-meta {
  height: 10px;
  width: 42%;
  animation-delay: 0.2s;
}

@keyframes shimmer {
  0%,
  100% {
    opacity: 1;
  }
  50% {
    opacity: 0.4;
  }
}
</style>
