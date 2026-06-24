<!-- OBSCURA — README -->

<div align="center">

[![CI](https://github.com/targoos/Obscura/actions/workflows/ci.yml/badge.svg)](https://github.com/targoos/Obscura/actions/workflows/ci.yml)
[![TypeScript](https://img.shields.io/badge/TypeScript-6.0-3178c6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Nuxt](https://img.shields.io/badge/Nuxt-4-00DC82?logo=nuxt.js&logoColor=white)](https://nuxt.com/)

# OBSCURA

### _"Algunos archivos no deberían existir."_

**Plataforma de investigación y archivo de casos de horror, ocultismo y fenómenos inexplicables.**

[**→ Ver en producción**](https://obscura.vercel.app) · [Contexto del proyecto](./AGENTS.md)

</div>

---

## El Proyecto

Obscura es una plataforma web full-stack construida como proyecto de portafolio profesional. Combina periodismo de investigación, narrativa perturbadora y exploración visual en una experiencia oscura e inmersiva.

La identidad visual y el tono están diseñados para sentirse como:

- **True Detective** meets **The X-Files**
- **Vice Documentales de lo oculto**
- Un archivo clasificado al que no deberías tener acceso

La experiencia completa —desde el diseño de base de datos hasta el sistema de diseño visual— fue construida bajo un flujo **Design Driven Development**: primero los archivos HTML de diseño abierto, luego la implementación en Nuxt, garantizando que la calidad visual nunca se negocia durante el desarrollo.

---

## Portfolio Highlights

| #   | Feature                       | Detalle                                                                                            |
| --- | ----------------------------- | -------------------------------------------------------------------------------------------------- |
| 1   | **Design Driven Development** | Diseño en HTML abierto con Claude Code antes de implementar. Sin sorpresas visuales en producción. |
| 2   | **Full-stack real**           | Nuxt 3 SSR · Supabase Auth · PostgreSQL con RLS · Storage · Realtime                               |
| 3   | **Design system propio**      | CSS variables con tokens semánticos (color, spacing, radius, shadows, transitions) + Tailwind v4   |
| 4   | **TypeScript estricto**       | Sin ningún `any` explícito. Tipos generados desde Supabase CLI. Props y emits siempre tipados.     |
| 5   | **CI/CD robusto**             | GitHub Actions: lint → typecheck → Vitest → build en cada PR. Deploy automático en push a `main`.  |
| 6   | **Auth real con roles**       | 4 roles (`visitor / reader / editor / admin`) con middleware de Nuxt y RLS policies en PostgreSQL. |

---

## Stack

| Capa          | Tecnología                                           |
| ------------- | ---------------------------------------------------- |
| **Framework** | Nuxt 4 (SSR + SSG híbrido)                           |
| **UI**        | Vue 3 · Composition API · `<script setup lang="ts">` |
| **Estilos**   | Tailwind CSS v4 · @nuxt/ui v4 · CSS variables        |
| **State**     | Pinia · VueUse                                       |
| **Auth & DB** | Supabase (PostgreSQL · Auth · Storage · Realtime)    |
| **Mapas**     | Leaflet · @vue-leaflet/vue-leaflet                   |
| **Testing**   | Vitest · @nuxt/test-utils · @pinia/testing           |
| **DX**        | ESLint · Prettier · Husky · lint-staged · Commitlint |
| **Deploy**    | Vercel (frontend + funciones serverless)             |

---

## Features

### Explorador de Casos

- Búsqueda en tiempo real con debounce de 300ms
- Filtros combinables: categoría · país · estado · etiquetas
- Orden por: más reciente · más antiguo · más visto · mejor valorado
- Toggle vista grilla / lista · scroll infinito

### Página de Detalle

- Hero con imagen principal en parallax + vignette
- Cronología visual de eventos
- Mapa interactivo con pin de ubicación exacta
- Tarjetas de teorías con nivel de credibilidad
- Sistema de valoración 1–5 estrellas
- Comentarios con moderación
- Casos relacionados por categoría y etiquetas
- Guardar en favoritos

### Mapa Mundial

- Todos los casos geolocalizados con marcadores
- Clustering por zoom · filtros por sidebar
- Popup con preview del caso · tema oscuro personalizado

### Panel de Administración

- Dashboard con métricas: casos por estado · usuarios · comentarios pendientes
- CRUD completo de casos con editor enriquecido
- Gestión de usuarios y cambio de roles
- Moderación de comentarios (aprobar / rechazar / spam)
- Gestión de categorías · países · etiquetas
- Configuración de caso del día · heroes · carrusel

### Auth Completo

- Email + contraseña · Google OAuth · GitHub OAuth
- Registro con verificación de email
- Recuperación de contraseña
- Sesión persistente con refresh token (Supabase SSR)

---

## Setup

```bash
# 1. Instalar dependencias
npm install

# 2. Configurar variables de entorno
cp .env.example .env

# 3. Iniciar dev server
npm run dev
```

### Variables de entorno

| Variable                        | Descripción                                      | Requerida |
| ------------------------------- | ------------------------------------------------ | --------- |
| `NUXT_PUBLIC_SUPABASE_URL`      | URL del proyecto en supabase.com                 | ✅        |
| `NUXT_PUBLIC_SUPABASE_ANON_KEY` | Clave pública (anon key) de Supabase             | ✅        |
| `SUPABASE_SERVICE_ROLE_KEY`     | Service role key — solo en funciones de servidor | ✅        |
| `NUXT_PUBLIC_APP_URL`           | URL de producción — usado para OG tags y sitemap | ✅        |

> Obtené las claves desde el dashboard de [Supabase](https://supabase.com/dashboard) → Settings → API.

---

## Arquitectura — Design Driven Development

El proyecto sigue un flujo en el que el diseño es el primer artefacto verificable, no el último.

```
┌─────────────────────────────────────────────────────────────────────┐
│  FASE 1 — OPEN DESIGN                                               │
│                                                                     │
│  Archivos HTML estáticos en /design/                                │
│  ├── obscura-home.html                                              │
│  ├── obscura-explorar.html                                          │
│  ├── obscura-case-detail.html                                       │
│  └── obscura-*.html                                                 │
│                                                                     │
│  Diseño visual completo antes de escribir Vue.                      │
│  Review de UI/UX sin fricción de framework.                         │
└───────────────────────────┬─────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────────┐
│  FASE 2 — DESIGN SYSTEM                                             │
│                                                                     │
│  app/assets/css/main.css                                            │
│  ├── CSS variables (color · spacing · radius · shadow · easing)     │
│  ├── Clases semánticas (.card-surface · .text-mystery-title)        │
│  └── Integración con Tailwind v4                                    │
└───────────────────────────┬─────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────────┐
│  FASE 3 — IMPLEMENTACIÓN                                            │
│                                                                     │
│  Componentes Vue extraídos del HTML de diseño                       │
│  ├── Composables para lógica de negocio                             │
│  ├── Páginas Nuxt con SSR/SSG según el tipo de ruta                 │
│  └── Supabase como backend headless                                 │
└─────────────────────────────────────────────────────────────────────┘
```

### Flujo de datos en producción

```
Browser → Nuxt SSR (Vercel Edge) → useAsyncData / useFetch
                                        │
                    ┌───────────────────┤
                    ▼                   ▼
            Supabase REST API    Nuxt Server API
            (PostgreSQL + RLS)   (/api/case-of-the-day
                    │             /api/views/[id]
                    │             /api/sitemap.xml)
                    ▼
            Supabase Storage
            (imágenes de casos)
```

---

## CI/CD Pipeline

```
Push / Pull Request a main
         │
         ▼
┌─────── ci.yml ──────────────────────────────────────────────────┐
│                                                                  │
│  1. Checkout + Setup Node 22                                     │
│  2. npm ci                                                       │
│  3. nuxi prepare                                                 │
│  4. ESLint ──────────────────────────────── ✅ / ❌ bloqueante   │
│  5. nuxi typecheck ──────────────────────── ✅ / ❌ bloqueante   │
│  6. vitest run ──────────────────────────── ✅ / ❌ bloqueante   │
│  7. nuxt build ──────────────────────────── ✅ / ❌ bloqueante   │
│                                                                  │
└──────────────────────────┬───────────────────────────────────────┘
                           │ Solo si CI pasa en main
                           ▼
┌─────── deploy.yml ──────────────────────────────────────────────┐
│                                                                  │
│  Vercel GitHub Integration                                       │
│  ├── Preview deploy en cada PR                                   │
│  └── Production deploy en merge a main                          │
│                                                                  │
│  Secrets inyectados desde GitHub Secrets:                        │
│  NUXT_PUBLIC_SUPABASE_URL · NUXT_PUBLIC_SUPABASE_ANON_KEY        │
│  VERCEL_TOKEN · VERCEL_ORG_ID · VERCEL_PROJECT_ID               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Estructura de Directorios

```
obscura/
├── app/
│   ├── assets/css/         → CSS variables · design system
│   ├── components/
│   │   ├── mystery/        → MysteryCard · MysteryHero · MysteryTimeline
│   │   ├── admin/          → AdminTable · AdminSidebar · AdminStats
│   │   ├── auth/           → AuthLoginForm · AuthRegisterForm
│   │   └── ui/             → componentes base reutilizables
│   ├── composables/        → 14 composables tipados
│   ├── layouts/            → default · auth · admin
│   ├── middleware/         → auth · admin · guest
│   ├── pages/              → rutas públicas · privadas · /admin
│   ├── stores/             → Pinia (auth · mysteries · favorites · ui)
│   └── types/              → mystery.ts · user.ts · supabase.ts
├── server/api/             → case-of-the-day · sitemap · views
├── supabase/
│   ├── migrations/         → SQL versionado
│   ├── seed.sql            → 30 casos de ejemplo
│   └── policies.sql        → RLS policies por tabla
├── design/                 → HTML de diseño abierto (pre-implementación)
└── tests/unit/             → composables · stores · utils
```

---

## Base de Datos

Esquema PostgreSQL con **Row Level Security** en todas las tablas.

| Tabla                   | Descripción                                                          |
| ----------------------- | -------------------------------------------------------------------- |
| `mysteries`             | Casos: título · slug · descripción · geolocalización · clasificación |
| `categories`            | Cultos · Paranormal · Asesinatos sin resolver · etc.                 |
| `countries`             | País · código · continente                                           |
| `timeline_events`       | Cronología de eventos por caso                                       |
| `theories`              | Teorías con `credibility_score` (0–100)                              |
| `sources`               | Fuentes y referencias externas                                       |
| `tags` + `mystery_tags` | Sistema de etiquetas M:N                                             |
| `profiles`              | Extiende `auth.users` — rol · reputación · avatar                    |
| `favorites`             | Casos guardados por usuario                                          |
| `ratings`               | Valoraciones 1–5 · una por usuario por caso                          |
| `comments`              | Con estado `pending / approved / spam`                               |
| `mystery_views`         | Tracking de visitas anónimas y autenticadas                          |
| `featured_content`      | Caso del día · hero · carrusel con vigencia temporal                 |

---

## Roles de Usuario

| Rol       | Descripción                                         |
| --------- | --------------------------------------------------- |
| `visitor` | No autenticado. Solo lectura pública.               |
| `reader`  | Registrado. Favoritos · valoraciones · comentarios. |
| `editor`  | Crear y editar casos. No puede publicar.            |
| `admin`   | Acceso total. Usuarios · contenido · estadísticas.  |

---

<div align="center">

Construido con obsesión por los detalles · **Obscura © 2026**

</div>
