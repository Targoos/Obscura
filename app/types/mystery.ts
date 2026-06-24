export type MysteryStatus = "published" | "draft" | "archived";
export type ClassificationLevel = "disturbing" | "extreme" | "classified";
export type CommentStatus = "pending" | "approved" | "spam";
export type RelationType =
  | "same_cult"
  | "same_region"
  | "related_victims"
  | "similar_modus";
export type FeaturedType = "day" | "hero" | "carousel";

export interface Category {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  icon: string | null;
  color: string | null;
  created_at: string;
}

export interface Country {
  id: string;
  name: string;
  code: string;
  flag_emoji: string | null;
  continent: string | null;
  created_at: string;
}

export interface Tag {
  id: string;
  name: string;
  slug: string;
  created_at: string;
}

export interface Mystery {
  id: string;
  slug: string;
  title: string;
  summary: string;
  description: string;
  status: MysteryStatus;
  classification_level: ClassificationLevel;
  image_url: string | null;
  latitude: number | null;
  longitude: number | null;
  year_occurred: number | null;
  views_count: number;
  rating_avg: number;
  rating_count: number;
  category_id: string;
  country_id: string | null;
  created_at: string;
  updated_at: string;
  published_at: string | null;
  created_by: string;
  category?: Category;
  country?: Country;
  tags?: Tag[];
}

export interface TimelineEvent {
  id: string;
  mystery_id: string;
  year: number;
  title: string;
  description: string;
  order: number;
  created_at: string;
}

export interface Theory {
  id: string;
  mystery_id: string;
  title: string;
  description: string;
  credibility_score: number;
  source_url: string | null;
  created_at: string;
}

export interface Source {
  id: string;
  mystery_id: string;
  title: string;
  url: string;
  type: string;
  year: number | null;
  created_at: string;
}

export interface MysteryDetail extends Mystery {
  timeline_events: TimelineEvent[];
  theories: Theory[];
  sources: Source[];
}

export interface Comment {
  id: string;
  user_id: string;
  mystery_id: string;
  content: string;
  status: CommentStatus;
  created_at: string;
  updated_at: string;
}

export interface MysteryRelation {
  mystery_id: string;
  related_mystery_id: string;
  relation_type: RelationType;
}

export interface FeaturedContent {
  id: string;
  mystery_id: string;
  type: FeaturedType;
  position: number | null;
  active: boolean;
  valid_from: string | null;
  valid_until: string | null;
  created_at: string;
  updated_by: string;
}
