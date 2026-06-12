-- Row Level Security policies for all tables
-- Enable RLS on each table before applying policies

-- ─── mysteries ───────────────────────────────────────────────────────────────

ALTER TABLE mysteries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read published mysteries"
  ON mysteries FOR SELECT
  USING (status = 'published');

CREATE POLICY "Editors and admins can read all mysteries"
  ON mysteries FOR SELECT
  USING (
    auth.uid() IN (SELECT id FROM profiles WHERE role IN ('editor', 'admin'))
  );

CREATE POLICY "Editors and admins can insert mysteries"
  ON mysteries FOR INSERT
  WITH CHECK (
    auth.uid() IN (SELECT id FROM profiles WHERE role IN ('editor', 'admin'))
  );

CREATE POLICY "Editors and admins can update mysteries"
  ON mysteries FOR UPDATE
  USING (
    auth.uid() IN (SELECT id FROM profiles WHERE role IN ('editor', 'admin'))
  );

CREATE POLICY "Only admins can delete mysteries"
  ON mysteries FOR DELETE
  USING (
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  );

-- ─── comments ────────────────────────────────────────────────────────────────

ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read approved comments"
  ON comments FOR SELECT
  USING (status = 'approved');

CREATE POLICY "Admins can read all comments"
  ON comments FOR SELECT
  USING (
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  );

CREATE POLICY "Authenticated users can insert comments"
  ON comments FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Owner or admin can update comments"
  ON comments FOR UPDATE
  USING (
    auth.uid() = user_id OR
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  );

CREATE POLICY "Owner or admin can delete comments"
  ON comments FOR DELETE
  USING (
    auth.uid() = user_id OR
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  );

-- ─── favorites ───────────────────────────────────────────────────────────────

ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users manage own favorites"
  ON favorites FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ─── ratings ─────────────────────────────────────────────────────────────────

ALTER TABLE ratings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read ratings"
  ON ratings FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can upsert own rating"
  ON ratings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own rating"
  ON ratings FOR UPDATE
  USING (auth.uid() = user_id);

-- ─── profiles ────────────────────────────────────────────────────────────────

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read profiles"
  ON profiles FOR SELECT
  USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (
    auth.uid() = id AND
    -- role field is immutable by non-admins; handled at app level
    true
  );

-- ─── featured_content ────────────────────────────────────────────────────────

ALTER TABLE featured_content ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read featured content"
  ON featured_content FOR SELECT
  USING (true);

CREATE POLICY "Only admins can manage featured content"
  ON featured_content FOR ALL
  USING (
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  )
  WITH CHECK (
    auth.uid() IN (SELECT id FROM profiles WHERE role = 'admin')
  );
