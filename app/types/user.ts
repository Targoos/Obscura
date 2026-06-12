export type UserRole = "visitor" | "reader" | "editor" | "admin";

export interface Profile {
  id: string;
  username: string;
  full_name: string | null;
  avatar_url: string | null;
  bio: string | null;
  role: UserRole;
  reputation_points: number;
  created_at: string;
  updated_at: string;
}

export interface Favorite {
  id: string;
  user_id: string;
  mystery_id: string;
  created_at: string;
}

export interface Rating {
  id: string;
  user_id: string;
  mystery_id: string;
  score: number;
  created_at: string;
}
