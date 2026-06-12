<script setup lang="ts"></script>

<template>
  <div class="min-h-screen flex">
    <AdminSidebar />
    <div class="flex-1 flex flex-col min-w-0">
      <header class="border-b border-[--color-border] px-6 py-4">
        <!-- TODO: admin topbar -->
      </header>
      <main class="flex-1 p-6 overflow-auto">
        <slot />
      </main>
    </div>
  </div>
</template>
