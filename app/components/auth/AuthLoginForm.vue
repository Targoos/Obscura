<script setup lang="ts">
const loading = ref(false);
const _error = ref<string | null>(null);

const _form = reactive({
  email: "",
  password: "",
});

async function onSubmit() {
  // TODO: useAuth().signIn(form)
}
</script>

<template>
  <form
    class="card-surface p-8 w-full max-w-sm"
    novalidate
    @submit.prevent="onSubmit"
  >
    <h1 class="text-mystery-title text-2xl mb-6">Iniciar Sesión</h1>
    <!-- TODO: email + password fields, OAuth buttons, error display -->
    <UButton type="submit" :loading="loading" block> Entrar </UButton>
  </form>
</template>
