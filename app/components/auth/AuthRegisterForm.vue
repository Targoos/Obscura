<script setup lang="ts">
const loading = ref(false);
const _error = ref<string | null>(null);

const _form = reactive({
  email: "",
  password: "",
  username: "",
});

async function onSubmit() {
  // TODO: useAuth().signUp(form)
}
</script>

<template>
  <form
    class="card-surface p-8 w-full max-w-sm"
    novalidate
    @submit.prevent="onSubmit"
  >
    <h1 class="text-mystery-title text-2xl mb-6">Crear Cuenta</h1>
    <!-- TODO: username, email, password fields, error display -->
    <UButton type="submit" :loading="loading" block> Registrarse </UButton>
  </form>
</template>
