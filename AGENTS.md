# AGENTS.md — Obscura

## Descripción del Proyecto

**Obscura** es una plataforma web de nivel profesional dedicada a documentar, investigar y archivar casos de horror, ocultismo y fenómenos inexplicables de todo el mundo.

El objetivo es combinar periodismo de investigación, narrativa perturbadora y exploración visual en una experiencia oscura e inmersiva.

La plataforma debe sentirse como una mezcla entre:

- True Detective meets The X-Files
- Vice Documentales de lo oculto
- Archivo clasificado de casos perturbadores
- Periodismo de investigación underground

El resultado final debe ser un proyecto digno de portafolio profesional que demuestre buenas prácticas en frontend, full stack, autenticación, roles de usuario y administración de contenido.

---

## Stack Tecnológico

### Frontend

- **Nuxt 3** (SSR + SSG híbrido)
- **Vue 3** con Composition API y `<script setup lang="ts">`
- **TypeScript** estricto
- **Tailwind CSS v4** + **@nuxt/ui v4**
- **Pinia** (state management)
- **VueUse** (composables utilitarios)

### Backend & Auth

- **Supabase** (PostgreSQL + Auth + Storage + Realtime)
- **Supabase Auth** con SSR helpers para Nuxt

### Mapas

- **Leaflet** + **vue-leaflet** (mapa interactivo)

### Despliegue

- **Vercel** (frontend + funciones serverless)
- **Supabase** (backend como servicio)

---

## Sistema de Autenticación

### Métodos de Login

- Email + contraseña
- Google OAuth
- GitHub OAuth (opcional, perfil técnico)

### Roles de Usuario

| Rol       | Descripción                                                     |
| --------- | --------------------------------------------------------------- |
| `visitor` | Usuario no autenticado. Solo lectura pública.                   |
| `reader`  | Usuario registrado. Puede guardar favoritos, valorar, comentar. |
| `editor`  | Puede crear y editar casos, pero no publicarlos.                |
| `admin`   | Acceso total. Gestión de usuarios, contenido y estadísticas.    |

### Flujos de Auth

- Registro con email y verificación
- Recuperación de contraseña por email
- Sesión persistente con refresh token (Supabase SSR)
- Protección de rutas con middleware de Nuxt

---

## Rutas de la Aplicación

### Rutas Públicas (sin auth)

| Ruta                    | Descripción                                 |
| ----------------------- | ------------------------------------------- |
| `/`                     | Home — Caso del día, destacados, categorías |
| `/explorar`             | Listado y búsqueda de todos los casos       |
| `/mapa`                 | Mapa mundial interactivo                    |
| `/caso/[slug]`          | Página de detalle de un caso                |
| `/categoria/[slug]`     | Filtrado por categoría                      |
| `/login`                | Inicio de sesión                            |
| `/registro`             | Crear cuenta                                |
| `/recuperar-contrasena` | Restablecer contraseña                      |

### Rutas Privadas (requieren `reader` o superior)

| Ruta             | Descripción                        |
| ---------------- | ---------------------------------- |
| `/perfil`        | Datos del usuario, avatar, bio     |
| `/favoritos`     | Casos guardados por el usuario     |
| `/historial`     | Últimos casos visitados            |
| `/configuracion` | Preferencias: tema, notificaciones |

### Rutas de Panel Admin (requieren `admin` o `editor`)

| Ruta                         | Descripción                                |
| ---------------------------- | ------------------------------------------ |
| `/admin`                     | Dashboard con métricas y resumen           |
| `/admin/casos`               | Listado de casos con CRUD                  |
| `/admin/casos/nuevo`         | Formulario de creación                     |
| `/admin/casos/[id]/editar`   | Formulario de edición                      |
| `/admin/usuarios`            | Gestión de usuarios y roles (solo `admin`) |
| `/admin/categorias`          | CRUD de categorías                         |
| `/admin/paises`              | CRUD de países                             |
| `/admin/etiquetas`           | Gestión de etiquetas                       |
| `/admin/comentarios`         | Moderación de comentarios                  |
| `/admin/contenido-destacado` | Caso del día, heroes y carrusel            |
| `/admin/estadisticas`        | Métricas de uso, visitas, tops             |

---

## Middleware de Nuxt

```
middleware/
  auth.ts          → Redirige a /login si no hay sesión
  admin.ts         → Verifica rol admin o editor
  guest.ts         → Redirige al home si ya está autenticado (login/registro)
```

Configuración en páginas:

```ts
// Cualquier usuario autenticado
definePageMeta({ middleware: ["auth"] });

// Solo admin o editor
definePageMeta({ middleware: ["auth", "admin"] });

// Solo visitantes (redirige si ya está autenticado)
definePageMeta({ middleware: ["guest"] });
```

---

## Panel de Administración

### Dashboard

- Total de casos por estado (publicado / borrador / archivado)
- Casos más vistos (últimos 7 días)
- Usuarios registrados (total + nuevos esta semana)
- Comentarios pendientes de moderación
- Categorías más populares (gráfico de barras)
- Mapa de calor de visitas por país

### Gestión de Casos

- Tabla paginada con búsqueda y filtros
- Acciones: crear, editar, publicar/despublicar, archivar, eliminar
- Editor enriquecido para descripción larga
- Carga de imagen principal (Supabase Storage)
- Gestión inline de: cronología, teorías, fuentes, etiquetas

### Gestión de Usuarios

- Tabla con: avatar, nombre, email, rol, fecha de registro
- Cambiar rol de usuario
- Suspender / reactivar cuenta
- Ver actividad del usuario

### Moderación de Comentarios

- Listado de comentarios con estado (aprobado / pendiente / spam)
- Aprobar, rechazar, eliminar comentarios
- Filtrar por caso, usuario o estado

---

## Características Principales

### Explorador de Casos

- Búsqueda en tiempo real (debounce 300ms)
- Filtros combinables: categoría, país, estado del caso, etiquetas
- Ordenar por: más reciente, más antiguo, más visto, más valorado
- Vista de grilla y lista (toggle)
- Paginación o scroll infinito

### Página de Detalle

- Hero con imagen principal en parallax
- Resumen editorial del caso
- Cronología visual de eventos
- Mapa con pin de ubicación exacta
- Sección de hechos conocidos (lista estructurada)
- Tarjetas de teorías con fuente
- Fuentes y referencias externas
- Casos relacionados (por categoría + etiquetas)
- Sistema de valoración (1-5 estrellas, usuarios autenticados)
- Comentarios con moderación
- Botón de guardar en favoritos

### Mapa Mundial Interactivo

- Todos los casos geolocalizados como marcadores
- Clustering de marcadores por zoom
- Filtros en el sidebar del mapa (categoría, país)
- Popup al hacer click: imagen, título, acceso al detalle
- Estilos de mapa personalizados (tema oscuro)

### Caso del Día

- Selección automática diaria (lógica en servidor o cron)
- Destacado visual en el home con atmósfera perturbadora
- Puede ser configurado manualmente desde el admin

---

## Categorías de Casos

- Cultos y sectas
- Asesinatos sin resolver
- Fenómenos paranormales
- Entidades y criaturas
- Rituales ocultistas
- Desapariciones inexplicables
- Lugares malditos
- Experimentos prohibidos
- Mensajes cifrados y conspiraciones
- Folklore oscuro y leyendas perturbadoras

---

## Ideas de Mejora y Diferenciación

### 1. Modo "Investigador"

Toggle que activa una vista alternativa del detalle con:

- Fuentes resaltadas visualmente
- Nivel de credibilidad de cada teoría (0-100)
- Nodos de conexión entre casos relacionados (mini grafo)
- Advertencia de contenido perturbador activable

### 2. Timeline Global Interactiva

Una página `/cronologia` que muestra todos los casos en un eje de tiempo visual, filtrable por siglo, década, categoría.

### 3. Sistema de Reputación — "Nivel de Iniciado"

Los usuarios acumulan puntos al contribuir. Niveles temáticos: Curioso → Investigador → Iniciado → Archivista.

### 4. "Conexiones" entre Casos

Relaciones explícitas: "mismo culto", "misma región", "víctimas relacionadas". Visualizable como grafo de red.

### 5. Mapa de Densidad por Categoría

En el mapa, toggle que colorea regiones según densidad de casos por tipo (cultos, paranormal, etc.).

### 6. Compartir como Imagen

Generar una tarjeta visual (OG-style) del caso con estética perturbadora para redes sociales.

### 7. Modo Lectura Inmersiva

Vista fullscreen que oculta la navegación, activa tipografía ampliada y efectos de atmósfera (ruido sutil, vignette).

### 8. Notificaciones en Tiempo Real

Supabase Realtime para notificar cuando un caso guardado recibe nueva información o comentarios.

### 9. Búsqueda Semántica (v2)

Integrar pgvector en Supabase para búsqueda por similitud semántica.

### 10. Soporte Multilingüe (v3)

Español e Inglés como idiomas base, con i18n de Nuxt.

### 11. Sistema de "Clasificación" de Casos

Nivel de perturbación del caso: Perturbador / Extremo / Clasificado. El nivel "Clasificado" requiere autenticación para ver el contenido completo.

---

## Modelo de Datos

### `mysteries`

```sql
id, slug, title, summary, description, status,
classification_level (disturbing/extreme/classified),
image_url, latitude, longitude, year_occurred,
views_count, rating_avg, rating_count,
category_id, country_id,
created_at, updated_at, published_at, created_by
```

### `categories`

```sql
id, name, slug, description, icon, color, created_at
```

### `countries`

```sql
id, name, code, flag_emoji, continent, created_at
```

### `timeline_events`

```sql
id, mystery_id, year, title, description, order, created_at
```

### `theories`

```sql
id, mystery_id, title, description, credibility_score, source_url, created_at
```

### `sources`

```sql
id, mystery_id, title, url, type, year, created_at
```

### `tags`

```sql
id, name, slug, created_at
```

### `mystery_tags`

```sql
mystery_id, tag_id
```

### `mystery_relations`

```sql
mystery_id, related_mystery_id, relation_type
```

### `profiles` (extiende auth.users de Supabase)

```sql
id (FK auth.users), username, full_name, avatar_url, bio,
role, reputation_points, created_at, updated_at
```

### `favorites`

```sql
id, user_id, mystery_id, created_at
```

### `ratings`

```sql
id, user_id, mystery_id, score (1-5), created_at
```

### `comments`

```sql
id, user_id, mystery_id, content, status (pending/approved/spam),
created_at, updated_at
```

### `mystery_views`

```sql
id, mystery_id, user_id (nullable), ip_hash, created_at
```

### `featured_content`

```sql
id, mystery_id, type (day/hero/carousel), position,
active, valid_from, valid_until,
created_at, updated_by
```

- `type = 'day'` → Caso del Día (uno activo a la vez)
- `type = 'hero'` → Banner principal del home
- `type = 'carousel'` → Sección destacados, ordenado por `position`

---

## Diseño Visual

### Identidad

- **Nombre:** Obscura
- **Tagline:** _"Algunos archivos no deberían existir."_
- **Tono:** Perturbador. Atmosférico. Tenso. Como acceder a archivos clasificados que alguien quiso ocultar.

### Paleta de Colores

```css
/* Tema Oscuro (único — no hay tema claro) */
--color-bg: #080808; /* negro absoluto */
--color-surface: #0f0f0f; /* superficies de cards */
--color-surface-2: #161616; /* cards elevadas, modales */
--color-border: #1f1f1f; /* bordes casi invisibles */
--color-muted: #444444; /* texto secundario */
--color-text: #d4d4d4; /* texto principal — gris frío */
--color-accent: #cc0000; /* rojo sangre — acento principal */
--color-accent-dim: #7a0000; /* rojo apagado para hovers y badges */
--color-accent-2: #8b0000; /* rojo oscuro alternativo */
--color-warning: #b8860b; /* amarillo oscuro para advertencias */
--color-danger: #ff2222; /* rojo brillante para alertas críticas */
--color-classified: #ff6600; /* naranja para casos clasificados */
```

### Tipografía

- **Display / Títulos:** `Cinzel` — serif romana, solemne, casi ritual
- **Body / UI:** `IBM Plex Sans` — sans-serif frío, técnico, como un informe policial
- **Monoespaciado / Datos / IDs:** `IBM Plex Mono` — para coordenadas, fechas, códigos de caso
- **Citas / Textos de archivo:** `Crimson Text` — serif antiguo para testimonios o citas de testigos

### Principios Visuales

- **Negro absoluto** como fondo — no dark gray, negro puro
- Fotografías en alto contraste, desaturadas, con vignette
- Textura de grano sutil en el fondo (film grain, CSS puro `opacity: 0.03`)
- Rojo sangre usado con precisión quirúrgica — no decorativo
- Efecto "documento clasificado" en cards: bordes rasgados, sellos, redacciones
- Animaciones: flickering sutil en títulos, fade-in lento tipo "decrypting"
- Sin bordes redondeados grandes — esquinas más duras (4px máximo)
- Scrollbar personalizado: delgado, rojo
- Navegación: máx. 2 niveles, minimalista, sin color

### Efectos de Atmósfera

- Overlay de ruido/grano en el `<body>` (CSS puro, `opacity: 0.03`)
- Vignette sutil en heroes y páginas de detalle
- Badges de estado: `CASO ABIERTO`, `ARCHIVADO`, `CLASIFICADO`, `SIN RESOLVER`
- `letter-spacing` amplio en títulos para sensación de distancia
- Líneas de separación estilo expediente (1px rojo o punteadas)

---

## Estructura de Directorios

```
obscura/
├── app/
│   ├── assets/
│   │   └── css/
│   │       └── main.css
│   ├── components/
│   │   ├── app/           → AppHeader, AppFooter, AppNav
│   │   ├── mystery/       → MysteryCard, MysteryHero, MysteryTimeline, etc.
│   │   ├── map/           → MapView, MapMarker, MapFilters
│   │   ├── admin/         → AdminTable, AdminStats, AdminSidebar
│   │   ├── auth/          → AuthLoginForm, AuthRegisterForm
│   │   └── ui/            → componentes base reutilizables
│   ├── composables/
│   │   ├── useAuth.ts
│   │   ├── useMysteries.ts
│   │   ├── useFavorites.ts
│   │   ├── useRatings.ts
│   │   ├── useComments.ts
│   │   ├── useFilters.ts
│   │   ├── usePagination.ts
│   │   ├── useInfiniteScroll.ts
│   │   ├── useDebounce.ts
│   │   ├── useMetaHead.ts
│   │   ├── useSupabaseImage.ts
│   │   ├── useRelativeTime.ts
│   │   ├── useTable.ts
│   │   ├── useCrud.ts
│   │   └── useAdmin.ts
│   ├── layouts/
│   │   ├── default.vue    → layout público
│   │   ├── auth.vue       → layout para login/registro
│   │   └── admin.vue      → layout del panel de admin
│   ├── middleware/
│   │   ├── auth.ts
│   │   ├── admin.ts
│   │   └── guest.ts
│   ├── pages/
│   │   ├── index.vue
│   │   ├── explorar.vue
│   │   ├── mapa.vue
│   │   ├── cronologia.vue
│   │   ├── caso/[slug].vue
│   │   ├── categoria/[slug].vue
│   │   ├── login.vue
│   │   ├── registro.vue
│   │   ├── recuperar-contrasena.vue
│   │   ├── perfil.vue
│   │   ├── favoritos.vue
│   │   ├── configuracion.vue
│   │   └── admin/
│   │       ├── index.vue
│   │       ├── casos/
│   │       │   ├── index.vue
│   │       │   ├── nuevo.vue
│   │       │   └── [id]/editar.vue
│   │       ├── usuarios/index.vue
│   │       ├── categorias/index.vue
│   │       ├── paises/index.vue
│   │       ├── etiquetas/index.vue
│   │       ├── comentarios/index.vue
│   │       ├── contenido-destacado/index.vue
│   │       └── estadisticas/index.vue
│   ├── stores/
│   │   ├── auth.ts
│   │   ├── mysteries.ts
│   │   ├── favorites.ts
│   │   └── ui.ts           → theme, sidebar state
│   └── types/
│       ├── mystery.ts
│       ├── user.ts
│       └── supabase.ts     → tipos generados por Supabase CLI
├── server/
│   └── api/
│       ├── case-of-the-day.get.ts      → selección diaria del caso
│       ├── sitemap.xml.get.ts          → sitemap dinámico
│       └── views/
│           └── [id].post.ts            → registro de visita (sin exponer DB)
├── public/
│   ├── robots.txt
│   └── sitemap.xml
├── supabase/
│   ├── migrations/         → SQL de migraciones
│   ├── seed.sql            → 30 casos de ejemplo (3 por categoría)
│   └── policies.sql        → RLS policies por tabla
├── nuxt.config.ts
├── app.config.ts
├── tailwind.config.ts
└── tsconfig.json
```

---

## Roadmap de Construcción

### Fase 1 — Fundamentos (MVP Core)

- [ ] Scaffolding del proyecto Nuxt 3
- [ ] Configuración de CI/CD (GitHub Actions: lint + typecheck + build + Vitest + deploy Vercel)
- [ ] Configuración de Supabase (auth, DB, storage)
- [ ] Diseño del esquema de base de datos + migraciones
- [ ] Sistema de autenticación completo (login, registro, OAuth)
- [ ] Middleware de rutas (auth, admin, guest)
- [ ] Layout público + layout admin
- [ ] Home page con caso del día y destacados
- [ ] Explorador de casos con búsqueda y filtros
- [ ] Página de detalle completa
- [ ] Mapa mundial interactivo

### Fase 2 — Funcionalidades de Usuario

- [ ] Sistema de favoritos
- [ ] Valoraciones (1-5 estrellas)
- [ ] Comentarios con moderación
- [ ] Perfil de usuario editable
- [ ] Historial de visitas
- [ ] Casos relacionados automáticos

### Fase 3 — Panel Admin

- [ ] Dashboard con métricas
- [ ] CRUD completo de casos (con editor enriquecido)
- [ ] Gestión de usuarios y roles
- [ ] Moderación de comentarios
- [ ] Gestión de categorías y etiquetas

### Fase 4 — Diferenciación y Optimización

- [ ] Cronología global interactiva (`/cronologia`)
- [ ] Modo Investigador en detalle
- [ ] SEO avanzado (sitemap, Schema.org, OG dinámico)
- [ ] Modo oscuro / claro con persistencia
- [ ] Lighthouse 90+ en todas las métricas
- [ ] Compartir como imagen (OG card generado)
- [ ] Notificaciones en tiempo real (Supabase Realtime)

---

## CI/CD

### Estructura de Workflows

```
.github/
└── workflows/
    ├── ci.yml       → lint + typecheck + build + tests en cada PR
    └── deploy.yml   → deploy automático a Vercel en push a main
```

### `ci.yml` — Pipeline de Integración Continua

Trigger: `pull_request` y `push` a `main`

Pasos en orden:

1. Checkout del código
2. Setup Node.js (versión LTS)
3. Instalar dependencias con `npm ci`
4. **Lint** — `npm run lint` (ESLint + Nuxt config)
5. **Typecheck** — `npm run typecheck` (`nuxi typecheck`)
6. **Unit Tests** — `npm run test` (Vitest)
7. **Build** — `npm run build` (verifica que compila correctamente)

### `deploy.yml` — Deploy Automático

Trigger: `push` a `main` (solo si `ci.yml` pasa)

Pasos:

1. Usa la **Vercel CLI** o la **Vercel GitHub Integration**
2. Deploy de preview en cada PR
3. Deploy de producción en merge a `main`
4. Variables de entorno de Supabase inyectadas desde GitHub Secrets

### Testing con Vitest

```
tests/
├── unit/
│   ├── composables/     → useAuth, useMysteries, useFilters
│   ├── utils/           → helpers de formato, slugify, etc.
│   └── stores/          → Pinia stores con createTestingPinia
└── setup.ts
```

Qué testear:

- Composables de lógica de negocio (`useFilters`, `useMysteries`)
- Stores de Pinia (mutations y getters)
- Funciones utilitarias puras
- NO testear componentes de UI ni llamadas a Supabase (mockear)

### GitHub Secrets requeridos

| Secret              | Uso                         |
| ------------------- | --------------------------- |
| `SUPABASE_URL`      | URL del proyecto Supabase   |
| `SUPABASE_ANON_KEY` | Clave pública de Supabase   |
| `VERCEL_TOKEN`      | Token de Vercel para deploy |
| `VERCEL_ORG_ID`     | ID de organización Vercel   |
| `VERCEL_PROJECT_ID` | ID del proyecto Vercel      |

---

## Estándares de Código

- TypeScript estricto en todos los archivos
- Composition API con `<script setup lang="ts">` siempre
- Componentes enfocados: una responsabilidad por componente
- Composables para lógica reutilizable o con estado
- Sin lógica duplicada entre páginas
- Props y emits tipados explícitamente
- ESLint sin errores (config Nuxt)
- Diseño responsive por defecto (mobile-first)
- Accesibilidad WCAG AA mínimo
- Barrel exports (`index.ts`) en cada carpeta de componentes y composables
- Tipos generados automáticamente por Supabase CLI (`supabase gen types typescript`)
- Sin ningún `any` explícito en el proyecto
- Manejo explícito de estados: `loading` / `error` / `empty` / `data` en cada fetch

---

## Arquitectura de Features

### Feature-based folder structure

Cada feature agrupa sus propias piezas en lugar de separar por tipo de archivo:

```
app/
├── components/
│   ├── mystery/
│   │   ├── MysteryCard.vue
│   │   ├── MysteryCardSkeleton.vue
│   │   ├── MysteryHero.vue
│   │   ├── MysteryTimeline.vue
│   │   ├── MysteryTheories.vue
│   │   ├── MysteryRelated.vue
│   │   └── index.ts
│   ├── admin/
│   │   ├── AdminTable.vue
│   │   ├── AdminSidebar.vue
│   │   ├── AdminStats.vue
│   │   └── index.ts
│   ├── auth/
│   │   ├── AuthLoginForm.vue
│   │   ├── AuthRegisterForm.vue
│   │   └── index.ts
│   └── ui/
│       ├── AppBreadcrumb.vue
│       ├── AppCommandPalette.vue
│       ├── EmptyState.vue
│       ├── ErrorState.vue
│       ├── StatusBadge.vue
│       ├── AvatarWithFallback.vue
│       ├── RatingStars.vue
│       ├── ConfirmDialog.vue
│       ├── InfiniteScrollSentinel.vue
│       └── index.ts
```

### Error handling global

- `error.vue` de Nuxt personalizado con diseño coherente al proyecto
- Cada `useAsyncData` / `useFetch` maneja explícitamente `error` y `status`
- Componente `<ErrorState />` con mensaje descriptivo + botón de retry
- Componente `<EmptyState />` para listas sin resultados

---

## Composables — Catálogo Completo

```
app/composables/
├── useAuth.ts              → sesión, login, logout, registro, OAuth
├── useMysteries.ts         → listado, detalle, búsqueda, filtros
├── useFavorites.ts         → toggle, lista, estado local
├── useRatings.ts           → valorar, leer puntuación
├── useComments.ts          → cargar, enviar, estado de moderación
├── useFilters.ts           → estado de filtros combinables
├── usePagination.ts        → página actual, total, cambio de página
├── useInfiniteScroll.ts    → sentinel + fetch de siguiente página
├── useDebounce.ts          → debounce reactivo para búsqueda
├── useMetaHead.ts          → wrapper de useSeoMeta() por tipo de página
├── useSupabaseImage.ts     → URLs firmadas y transformaciones de Storage
├── useRelativeTime.ts      → "hace 3 días" con Intl.RelativeTimeFormat
├── useTable.ts             → estado genérico para tablas del admin
├── useCrud.ts              → create/update/remove genérico por recurso
└── useAdmin.ts             → métricas y acciones del dashboard
```

### Patrón `useTable(resource)` — evita repetición en admin

```ts
const { data, loading, page, search, sort, refresh } = useTable("mysteries");
```

Una sola implementación alimenta `/admin/casos`, `/admin/usuarios`, `/admin/comentarios`.

### Patrón `useCrud(resource)` — operaciones CRUD genéricas

```ts
const { create, update, remove, loading, error } = useCrud("categories");
```

---

## Sistema de Diseño

### Design Tokens en CSS variables

No solo colores — un sistema completo:

```css
/* Espaciado */
--space-1: 0.25rem;
--space-2: 0.5rem;
--space-4: 1rem;
--space-6: 1.5rem;
--space-8: 2rem;
--space-16: 4rem;

/* Radios */
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 12px;
--radius-xl: 20px;

/* Sombras */
--shadow-card: 0 1px 3px rgba(0, 0, 0, 0.4), 0 4px 16px rgba(0, 0, 0, 0.2);
--shadow-modal: 0 8px 40px rgba(0, 0, 0, 0.6);

/* Transiciones */
--duration-fast: 150ms;
--duration-base: 250ms;
--duration-slow: 400ms;
--ease-out: cubic-bezier(0.16, 1, 0.3, 1);
```

### Clases utilitarias semánticas

```css
.text-mystery-title  /* Playfair Display, tamaño hero */
.text-editorial      /* DM Sans, cuerpo largo, line-height cómodo */
.text-mono-data      /* JetBrains Mono para coordenadas, IDs, fechas */
.card-surface        /* bg-surface + border + shadow en un lugar */
.section-padding     /* padding consistente entre secciones de página */
.focus-ring          /* outline rediseñado, visible pero estético */
```

### Skeleton loaders

Cada componente con carga asíncrona tiene su skeleton gemelo:

| Componente        | Skeleton                              |
| ----------------- | ------------------------------------- |
| `<MysteryCard />` | `<MysteryCardSkeleton />`             |
| `<MysteryHero />` | `<MysteryHeroSkeleton />`             |
| `<AdminTable />`  | filas de skeleton con `animate-pulse` |

### Micro-animaciones con propósito

- `view-transition` de Nuxt entre páginas (sin librerías externas)
- Fade + slide en cards al entrar en viewport con `useIntersectionObserver` (VueUse)
- Hover states con `transform: translateY(-2px)` en cards
- Todas las transiciones respetan `prefers-reduced-motion`
- **No** usar `animate-*` de Tailwind de forma genérica

---

## Catálogo de Componentes UI Base

| Componente                   | Descripción                                                |
| ---------------------------- | ---------------------------------------------------------- |
| `<AppBreadcrumb />`          | Navegación semántica, SEO-friendly con `aria-label`        |
| `<AppCommandPalette />`      | Búsqueda global con `Cmd+K` (defineShortcuts de @nuxt/ui)  |
| `<MysteryCardSkeleton />`    | Skeleton con forma exacta del card                         |
| `<EmptyState />`             | Slot de icono + título + descripción + acción              |
| `<ErrorState />`             | Mensaje de error + botón retry tipado                      |
| `<ConfirmDialog />`          | Modal de confirmación reutilizable (acciones destructivas) |
| `<StatusBadge />`            | Publicado / Borrador / Archivado con colores semánticos    |
| `<AvatarWithFallback />`     | Avatar con inicial generada si no hay imagen               |
| `<InfiniteScrollSentinel />` | Trigger de scroll infinito con IntersectionObserver        |
| `<RatingStars />`            | Valoración 1-5 interactiva + solo lectura                  |

---

## DX — Developer Experience

### Husky + lint-staged

Pre-commit hook que corre ESLint + Prettier solo en archivos modificados.
El CI no es la primera línea de defensa.

```json
"lint-staged": {
  "*.{ts,vue}": ["eslint --fix", "prettier --write"],
  "*.{css,md}": ["prettier --write"]
}
```

### Commitlint + Conventional Commits

Historial de git legible y semántico:

```
feat: agregar sistema de favoritos
fix: corregir filtro de categorías en /explorar
chore: actualizar dependencias
docs: documentar composable useFilters
perf: lazy load del mapa en /mapa
```

### `.env.example`

Nunca `.env` en el repositorio. Siempre un `.env.example` con todas las variables documentadas:

```env
# Supabase
NUXT_PUBLIC_SUPABASE_URL=         # URL del proyecto en supabase.com
NUXT_PUBLIC_SUPABASE_ANON_KEY=    # Clave pública (anon key)
SUPABASE_SERVICE_ROLE_KEY=        # Solo para funciones de servidor

# App
NUXT_PUBLIC_APP_URL=              # URL de producción para OG tags
```

### README profesional

- Badge de estado del CI (GitHub Actions)
- Screenshots del proyecto en dark mode
- Setup en 3 comandos
- Tabla de variables de entorno
- Link al deploy en producción
- Link al AGENTS.md para contexto del proyecto

---

## Performance

### Imágenes

- `<NuxtImg>` con `loading="lazy"`, `format="webp"`, `sizes` responsive
- Todas las imágenes de Supabase Storage pasan por `@nuxt/image`
- Placeholder blur mientras carga

### Code Splitting

- Componentes pesados (mapa, editor admin) como `defineAsyncComponent`
- Solo cargan cuando la ruta los necesita

### Prefetch

- `<NuxtLink prefetch>` en cards de casos para precargar el detalle en hover

### Objetivos Lighthouse

| Métrica        | Objetivo |
| -------------- | -------- |
| Performance    | ≥ 90     |
| Accessibility  | ≥ 95     |
| Best Practices | ≥ 95     |
| SEO            | ≥ 95     |

---

## Accesibilidad — Checklist

- `aria-label` en todos los botones con solo icono
- `focus-visible` estilizado (no ocultar el outline, rediseñarlo)
- `prefers-reduced-motion` respetado en todas las animaciones
- `alt` descriptivos en todas las imágenes
- Errores de formulario asociados con `aria-describedby`
- Navegación completa por teclado (Tab, Enter, Escape)
- Contraste mínimo 4.5:1 en texto normal, 3:1 en texto grande
- Landmarks HTML semánticos: `<header>`, `<main>`, `<nav>`, `<footer>`, `<aside>`

---

## Seguridad — Row Level Security (RLS)

Todas las tablas tienen RLS habilitado en Supabase. Pol\u00edticas principales:

### `mysteries`

- **SELECT p\u00fablico:** solo filas con `status = 'published'`
- **SELECT admin/editor:** todas las filas
- **INSERT/UPDATE:** solo usuarios con rol `editor` o `admin`
- **DELETE:** solo `admin`

### `comments`

- **SELECT:** solo `status = 'approved'` para p\u00fablico; todas para `admin`
- **INSERT:** usuarios autenticados (`reader`+), con `status = 'pending'` por defecto
- **UPDATE/DELETE:** propietario del comentario o `admin`

### `favorites`

- **SELECT/INSERT/DELETE:** solo el propio usuario (`user_id = auth.uid()`)

### `ratings`

- **SELECT:** p\u00fablico (para mostrar promedio)
- **INSERT/UPDATE:** usuario autenticado, una valoraci\u00f3n por misterio

### `profiles`

- **SELECT:** p\u00fablico (username, avatar, bio)
- **UPDATE:** solo el propio usuario; campo `role` solo modificable por `admin`

### `featured_content`

- **SELECT:** p\u00fablico
- **INSERT/UPDATE/DELETE:** solo `admin`

---

## SEO T\u00e9cnico

### Estrategia por tipo de p\u00e1gina

| P\u00e1gina         | Title                                                      | Description                         | OG Image                  |
| ------------------- | ---------------------------------------------------------- | ----------------------------------- | ------------------------- |
| Home                | "Obscura \u2014 Algunos archivos no deber\u00edan existir" | Tagline del sitio                   | OG est\u00e1tica de marca |
| `/caso/[slug]`      | `{title} \u2014 Obscura`                                   | `{summary}` (160 chars)             | `{image_url}` del caso    |
| `/explorar`         | "Explorar Casos \u2014 Obscura"                            | Descripci\u00f3n de la secci\u00f3n | OG est\u00e1tica          |
| `/categoria/[slug]` | `{category.name} \u2014 Obscura`                           | `{category.description}`            | OG con color cat.         |

### `useMetaHead(type, data)` — wrapper de `useSeoMeta`

```ts
// En p\u00e1gina de detalle
useMetaHead("mystery", { title, summary, image_url, slug });

// Genera autom\u00e1ticamente:
// - title, description
// - og:title, og:description, og:image, og:url
// - twitter:card, twitter:title, twitter:image
// - canonical URL
```

### Schema.org por tipo de contenido

- **P\u00e1gina de detalle:** `Article` + `Place` (con coordenadas geogr\u00e1ficas)
- **Home:** `WebSite` + `SearchAction` (sitelinks searchbox)
- **Categor\u00eda:** `CollectionPage`
- **Cronolog\u00eda:** `Event` por cada entrada del timeline

### Sitemap din\u00e1mico

`server/api/sitemap.xml.get.ts` genera el sitemap consultando la DB:

- Todas las rutas est\u00e1ticas con `changefreq` y `priority`
- Un `<url>` por cada caso publicado con `lastmod = updated_at`
- Un `<url>` por cada categor\u00eda

### `robots.txt`

```
User-agent: *
Allow: /
Disallow: /admin/
Disallow: /perfil
Disallow: /favoritos
Sitemap: https://obscura.vercel.app/sitemap.xml
```

---

## Rendering H\u00edbrido (routeRules)

Configurado en `nuxt.config.ts` mediante `routeRules`:

```ts
routeRules: {
  // P\u00e1ginas est\u00e1ticas — pre-renderizadas en build
  '/':              { prerender: true },
  '/explorar':      { ssr: true },          // SSR: filtros din\u00e1micos

  // ISR: se regenera autom\u00e1ticamente cada 24h
  '/misterio/**':   { isr: 86400 },
  '/categoria/**':  { isr: 86400 },

  // Client-only: Leaflet no es compatible con SSR
  '/mapa':          { ssr: false },

  // SPA pura: panel admin no necesita SSR ni indexaci\u00f3n
  '/admin/**':      { ssr: false },

  // Rutas privadas: SSR con redireccionamiento via middleware
  '/perfil':        { ssr: true },
  '/favoritos':     { ssr: true },
}
```

---

## Objetivo Final

Obscura debe demostrar:

- Arquitectura Nuxt 3 moderna con SSR/SSG híbrido
- Autenticación real con roles y rutas protegidas
- Panel de administración funcional y completo
- Integración full stack con Supabase
- Diseño UX/UI de nivel profesional con sistema de diseño propio
- SEO técnico avanzado
- Código limpio, desacoplado y escalable (DRY, feature-based, tipado end-to-end)
- Composables bien abstraídos y reutilizables
- CI/CD completo desde el día 1
- Accesibilidad WCAG AA real, no cosmética
- Performance Lighthouse 90+ en todas las métricas
- DX profesional: Husky, Commitlint, `.env.example`, README con badges
- Capacidad de evolución (roadmap claro)

> _"Algunos archivos no deberían existir."_
