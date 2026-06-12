-- Seed data: 10 categories + 30 mysteries (3 per category)
-- TODO: populate with realistic dark/occult case data

-- Categories
INSERT INTO categories (name, slug, description, icon, color) VALUES
  ('Cultos y Sectas', 'cultos-y-sectas', 'Organizaciones secretas con rituales perturbadores', 'skull', '#cc0000'),
  ('Asesinatos Sin Resolver', 'asesinatos-sin-resolver', 'Crímenes que la justicia no pudo cerrar', 'eye', '#8b0000'),
  ('Fenómenos Paranormales', 'fenomenos-paranormales', 'Sucesos que desafían la explicación científica', 'ghost', '#444444'),
  ('Entidades y Criaturas', 'entidades-y-criaturas', 'Seres documentados en testimonios reales', 'triangle-alert', '#7a0000'),
  ('Rituales Ocultistas', 'rituales-ocultistas', 'Prácticas esotéricas con consecuencias reales', 'flame', '#cc0000'),
  ('Desapariciones Inexplicables', 'desapariciones-inexplicables', 'Personas que se esfumaron sin rastro', 'search', '#b8860b'),
  ('Lugares Malditos', 'lugares-malditos', 'Ubicaciones con historias de horror documentadas', 'map-pin', '#444444'),
  ('Experimentos Prohibidos', 'experimentos-prohibidos', 'Proyectos científicos que cruzaron líneas éticas', 'flask', '#8b0000'),
  ('Mensajes Cifrados y Conspiraciones', 'mensajes-cifrados', 'Códigos, comunicaciones ocultas y tramas encubiertas', 'lock', '#b8860b'),
  ('Folklore Oscuro', 'folklore-oscuro', 'Leyendas y mitos con raíces en hechos reales', 'book-open', '#7a0000');
