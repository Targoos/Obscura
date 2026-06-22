-- ============================================================================
-- Obscura — Initial Schema
-- ============================================================================
-- Creates all core tables respecting foreign key ordering.
-- RLS policies and seed data are handled in separate migrations.
-- ============================================================================

-- ─── 1. categories ──────────────────────────────────────────────────────────
CREATE TABLE categories (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL,
  slug        text NOT NULL UNIQUE,
  description text,
  icon        text,
  color       text,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- ─── 2. countries ───────────────────────────────────────────────────────────
CREATE TABLE countries (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL,
  code        text NOT NULL UNIQUE,
  flag_emoji  text,
  continent   text,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- ─── 3. mysteries ───────────────────────────────────────────────────────────
CREATE TABLE mysteries (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug                 text NOT NULL UNIQUE,
  title                text NOT NULL,
  summary              text,
  description          text,
  status               text NOT NULL DEFAULT 'draft'
                         CHECK (status IN ('draft', 'published', 'archived')),
  classification_level text NOT NULL DEFAULT 'disturbing'
                         CHECK (classification_level IN ('disturbing', 'extreme', 'classified')),
  image_url            text,
  latitude             double precision,
  longitude            double precision,
  year_occurred        integer,
  views_count          integer NOT NULL DEFAULT 0,
  rating_avg           numeric(3, 2) NOT NULL DEFAULT 0,
  rating_count         integer NOT NULL DEFAULT 0,
  category_id          uuid REFERENCES categories (id) ON DELETE SET NULL,
  country_id           uuid REFERENCES countries (id) ON DELETE SET NULL,
  created_at           timestamptz NOT NULL DEFAULT now(),
  updated_at           timestamptz NOT NULL DEFAULT now(),
  published_at         timestamptz,
  created_by           uuid REFERENCES auth.users (id) ON DELETE SET NULL
);

CREATE INDEX idx_mysteries_category_id ON mysteries (category_id);
CREATE INDEX idx_mysteries_country_id ON mysteries (country_id);
CREATE INDEX idx_mysteries_status ON mysteries (status);

-- ─── 4. profiles ────────────────────────────────────────────────────────────
CREATE TABLE profiles (
  id                uuid PRIMARY KEY REFERENCES auth.users (id) ON DELETE CASCADE,
  username          text UNIQUE,
  full_name         text,
  avatar_url        text,
  bio               text,
  role              text NOT NULL DEFAULT 'reader'
                      CHECK (role IN ('reader', 'editor', 'admin')),
  reputation_points integer NOT NULL DEFAULT 0,
  created_at        timestamptz NOT NULL DEFAULT now(),
  updated_at        timestamptz NOT NULL DEFAULT now()
);

-- ─── 5. timeline_events ─────────────────────────────────────────────────────
CREATE TABLE timeline_events (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mystery_id  uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  year        integer,
  title       text NOT NULL,
  description text,
  "order"     integer NOT NULL DEFAULT 0,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_timeline_events_mystery_id ON timeline_events (mystery_id);

-- ─── 6. theories ────────────────────────────────────────────────────────────
CREATE TABLE theories (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mystery_id        uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  title             text NOT NULL,
  description       text,
  credibility_score integer CHECK (credibility_score BETWEEN 0 AND 100),
  source_url        text,
  created_at        timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_theories_mystery_id ON theories (mystery_id);

-- ─── 7. sources ─────────────────────────────────────────────────────────────
CREATE TABLE sources (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mystery_id  uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  title       text NOT NULL,
  url         text,
  type        text,
  year        integer,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_sources_mystery_id ON sources (mystery_id);

-- ─── 8. tags ────────────────────────────────────────────────────────────────
CREATE TABLE tags (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text NOT NULL,
  slug       text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- ─── 9. mystery_tags ────────────────────────────────────────────────────────
CREATE TABLE mystery_tags (
  mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  tag_id     uuid NOT NULL REFERENCES tags (id) ON DELETE CASCADE,
  PRIMARY KEY (mystery_id, tag_id)
);

-- ─── 10. mystery_relations ──────────────────────────────────────────────────
CREATE TABLE mystery_relations (
  mystery_id         uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  related_mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  relation_type      text,
  PRIMARY KEY (mystery_id, related_mystery_id),
  CHECK (mystery_id <> related_mystery_id)
);

-- ─── 11. favorites ──────────────────────────────────────────────────────────
CREATE TABLE favorites (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, mystery_id)
);

CREATE INDEX idx_favorites_user_id ON favorites (user_id);
CREATE INDEX idx_favorites_mystery_id ON favorites (mystery_id);

-- ─── 12. ratings ────────────────────────────────────────────────────────────
CREATE TABLE ratings (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  score      integer NOT NULL CHECK (score BETWEEN 1 AND 5),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, mystery_id)
);

CREATE INDEX idx_ratings_mystery_id ON ratings (mystery_id);

-- ─── 13. comments ───────────────────────────────────────────────────────────
CREATE TABLE comments (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  content    text NOT NULL,
  status     text NOT NULL DEFAULT 'pending'
               CHECK (status IN ('pending', 'approved', 'spam')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_comments_mystery_id ON comments (mystery_id);
CREATE INDEX idx_comments_user_id ON comments (user_id);
CREATE INDEX idx_comments_status ON comments (status);

-- ─── 14. mystery_views ──────────────────────────────────────────────────────
CREATE TABLE mystery_views (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mystery_id uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  user_id    uuid REFERENCES auth.users (id) ON DELETE SET NULL,
  ip_hash    text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_mystery_views_mystery_id ON mystery_views (mystery_id);
CREATE INDEX idx_mystery_views_created_at ON mystery_views (created_at);

-- ─── 15. featured_content ───────────────────────────────────────────────────
CREATE TABLE featured_content (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mystery_id  uuid NOT NULL REFERENCES mysteries (id) ON DELETE CASCADE,
  type        text NOT NULL CHECK (type IN ('day', 'hero', 'carousel')),
  position    integer NOT NULL DEFAULT 0,
  active       boolean NOT NULL DEFAULT true,
  valid_from  timestamptz,
  valid_until timestamptz,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_by  uuid REFERENCES auth.users (id) ON DELETE SET NULL
);

CREATE INDEX idx_featured_content_type ON featured_content (type);
CREATE INDEX idx_featured_content_active ON featured_content (active);
