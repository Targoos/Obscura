-- ─── Auto-creación de perfil al registrar un usuario ────────────────────────
-- Cuando se crea un registro en auth.users, se inserta automáticamente un
-- perfil en public.profiles con role='reader' y un username derivado del email
-- (o del metadata 'username' provisto en el signUp).

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  base_username text;
  final_username text;
  suffix integer := 0;
BEGIN
  -- Preferir el username del metadata; si no, derivarlo del email.
  base_username := COALESCE(
    NULLIF(NEW.raw_user_meta_data ->> 'username', ''),
    split_part(NEW.email, '@', 1)
  );

  -- Normalizar a un slug seguro.
  base_username := lower(regexp_replace(base_username, '[^a-zA-Z0-9_]', '', 'g'));
  IF base_username = '' THEN
    base_username := 'usuario';
  END IF;

  -- Garantizar unicidad del username.
  final_username := base_username;
  WHILE EXISTS (SELECT 1 FROM public.profiles WHERE username = final_username) LOOP
    suffix := suffix + 1;
    final_username := base_username || suffix::text;
  END LOOP;

  INSERT INTO public.profiles (id, username, full_name, avatar_url, role)
  VALUES (
    NEW.id,
    final_username,
    NULLIF(NEW.raw_user_meta_data ->> 'full_name', ''),
    NULLIF(NEW.raw_user_meta_data ->> 'avatar_url', ''),
    'reader'
  );

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();
