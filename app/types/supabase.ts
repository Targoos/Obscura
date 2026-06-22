export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5";
  };
  public: {
    Tables: {
      categories: {
        Row: {
          color: string | null;
          created_at: string;
          description: string | null;
          icon: string | null;
          id: string;
          name: string;
          slug: string;
        };
        Insert: {
          color?: string | null;
          created_at?: string;
          description?: string | null;
          icon?: string | null;
          id?: string;
          name: string;
          slug: string;
        };
        Update: {
          color?: string | null;
          created_at?: string;
          description?: string | null;
          icon?: string | null;
          id?: string;
          name?: string;
          slug?: string;
        };
        Relationships: [];
      };
      comments: {
        Row: {
          content: string;
          created_at: string;
          id: string;
          mystery_id: string;
          status: string;
          updated_at: string;
          user_id: string;
        };
        Insert: {
          content: string;
          created_at?: string;
          id?: string;
          mystery_id: string;
          status?: string;
          updated_at?: string;
          user_id: string;
        };
        Update: {
          content?: string;
          created_at?: string;
          id?: string;
          mystery_id?: string;
          status?: string;
          updated_at?: string;
          user_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "comments_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      countries: {
        Row: {
          code: string;
          continent: string | null;
          created_at: string;
          flag_emoji: string | null;
          id: string;
          name: string;
        };
        Insert: {
          code: string;
          continent?: string | null;
          created_at?: string;
          flag_emoji?: string | null;
          id?: string;
          name: string;
        };
        Update: {
          code?: string;
          continent?: string | null;
          created_at?: string;
          flag_emoji?: string | null;
          id?: string;
          name?: string;
        };
        Relationships: [];
      };
      favorites: {
        Row: {
          created_at: string;
          id: string;
          mystery_id: string;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          mystery_id: string;
          user_id: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          mystery_id?: string;
          user_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "favorites_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      featured_content: {
        Row: {
          active: boolean;
          created_at: string;
          id: string;
          mystery_id: string;
          position: number;
          type: string;
          updated_by: string | null;
          valid_from: string | null;
          valid_until: string | null;
        };
        Insert: {
          active?: boolean;
          created_at?: string;
          id?: string;
          mystery_id: string;
          position?: number;
          type: string;
          updated_by?: string | null;
          valid_from?: string | null;
          valid_until?: string | null;
        };
        Update: {
          active?: boolean;
          created_at?: string;
          id?: string;
          mystery_id?: string;
          position?: number;
          type?: string;
          updated_by?: string | null;
          valid_from?: string | null;
          valid_until?: string | null;
        };
        Relationships: [
          {
            foreignKeyName: "featured_content_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      mysteries: {
        Row: {
          category_id: string | null;
          classification_level: string;
          country_id: string | null;
          created_at: string;
          created_by: string | null;
          description: string | null;
          id: string;
          image_url: string | null;
          latitude: number | null;
          longitude: number | null;
          published_at: string | null;
          rating_avg: number;
          rating_count: number;
          slug: string;
          status: string;
          summary: string | null;
          title: string;
          updated_at: string;
          views_count: number;
          year_occurred: number | null;
        };
        Insert: {
          category_id?: string | null;
          classification_level?: string;
          country_id?: string | null;
          created_at?: string;
          created_by?: string | null;
          description?: string | null;
          id?: string;
          image_url?: string | null;
          latitude?: number | null;
          longitude?: number | null;
          published_at?: string | null;
          rating_avg?: number;
          rating_count?: number;
          slug: string;
          status?: string;
          summary?: string | null;
          title: string;
          updated_at?: string;
          views_count?: number;
          year_occurred?: number | null;
        };
        Update: {
          category_id?: string | null;
          classification_level?: string;
          country_id?: string | null;
          created_at?: string;
          created_by?: string | null;
          description?: string | null;
          id?: string;
          image_url?: string | null;
          latitude?: number | null;
          longitude?: number | null;
          published_at?: string | null;
          rating_avg?: number;
          rating_count?: number;
          slug?: string;
          status?: string;
          summary?: string | null;
          title?: string;
          updated_at?: string;
          views_count?: number;
          year_occurred?: number | null;
        };
        Relationships: [
          {
            foreignKeyName: "mysteries_category_id_fkey";
            columns: ["category_id"];
            isOneToOne: false;
            referencedRelation: "categories";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "mysteries_country_id_fkey";
            columns: ["country_id"];
            isOneToOne: false;
            referencedRelation: "countries";
            referencedColumns: ["id"];
          },
        ];
      };
      mystery_relations: {
        Row: {
          mystery_id: string;
          related_mystery_id: string;
          relation_type: string | null;
        };
        Insert: {
          mystery_id: string;
          related_mystery_id: string;
          relation_type?: string | null;
        };
        Update: {
          mystery_id?: string;
          related_mystery_id?: string;
          relation_type?: string | null;
        };
        Relationships: [
          {
            foreignKeyName: "mystery_relations_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "mystery_relations_related_mystery_id_fkey";
            columns: ["related_mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      mystery_tags: {
        Row: {
          mystery_id: string;
          tag_id: string;
        };
        Insert: {
          mystery_id: string;
          tag_id: string;
        };
        Update: {
          mystery_id?: string;
          tag_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "mystery_tags_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "mystery_tags_tag_id_fkey";
            columns: ["tag_id"];
            isOneToOne: false;
            referencedRelation: "tags";
            referencedColumns: ["id"];
          },
        ];
      };
      mystery_views: {
        Row: {
          created_at: string;
          id: string;
          ip_hash: string | null;
          mystery_id: string;
          user_id: string | null;
        };
        Insert: {
          created_at?: string;
          id?: string;
          ip_hash?: string | null;
          mystery_id: string;
          user_id?: string | null;
        };
        Update: {
          created_at?: string;
          id?: string;
          ip_hash?: string | null;
          mystery_id?: string;
          user_id?: string | null;
        };
        Relationships: [
          {
            foreignKeyName: "mystery_views_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      profiles: {
        Row: {
          avatar_url: string | null;
          bio: string | null;
          created_at: string;
          full_name: string | null;
          id: string;
          reputation_points: number;
          role: string;
          updated_at: string;
          username: string | null;
        };
        Insert: {
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          full_name?: string | null;
          id: string;
          reputation_points?: number;
          role?: string;
          updated_at?: string;
          username?: string | null;
        };
        Update: {
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          full_name?: string | null;
          id?: string;
          reputation_points?: number;
          role?: string;
          updated_at?: string;
          username?: string | null;
        };
        Relationships: [];
      };
      ratings: {
        Row: {
          created_at: string;
          id: string;
          mystery_id: string;
          score: number;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          mystery_id: string;
          score: number;
          user_id: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          mystery_id?: string;
          score?: number;
          user_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "ratings_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      sources: {
        Row: {
          created_at: string;
          id: string;
          mystery_id: string;
          title: string;
          type: string | null;
          url: string | null;
          year: number | null;
        };
        Insert: {
          created_at?: string;
          id?: string;
          mystery_id: string;
          title: string;
          type?: string | null;
          url?: string | null;
          year?: number | null;
        };
        Update: {
          created_at?: string;
          id?: string;
          mystery_id?: string;
          title?: string;
          type?: string | null;
          url?: string | null;
          year?: number | null;
        };
        Relationships: [
          {
            foreignKeyName: "sources_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      tags: {
        Row: {
          created_at: string;
          id: string;
          name: string;
          slug: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          name: string;
          slug: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          name?: string;
          slug?: string;
        };
        Relationships: [];
      };
      theories: {
        Row: {
          created_at: string;
          credibility_score: number | null;
          description: string | null;
          id: string;
          mystery_id: string;
          source_url: string | null;
          title: string;
        };
        Insert: {
          created_at?: string;
          credibility_score?: number | null;
          description?: string | null;
          id?: string;
          mystery_id: string;
          source_url?: string | null;
          title: string;
        };
        Update: {
          created_at?: string;
          credibility_score?: number | null;
          description?: string | null;
          id?: string;
          mystery_id?: string;
          source_url?: string | null;
          title?: string;
        };
        Relationships: [
          {
            foreignKeyName: "theories_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
      timeline_events: {
        Row: {
          created_at: string;
          description: string | null;
          id: string;
          mystery_id: string;
          order: number;
          title: string;
          year: number | null;
        };
        Insert: {
          created_at?: string;
          description?: string | null;
          id?: string;
          mystery_id: string;
          order?: number;
          title: string;
          year?: number | null;
        };
        Update: {
          created_at?: string;
          description?: string | null;
          id?: string;
          mystery_id?: string;
          order?: number;
          title?: string;
          year?: number | null;
        };
        Relationships: [
          {
            foreignKeyName: "timeline_events_mystery_id_fkey";
            columns: ["mystery_id"];
            isOneToOne: false;
            referencedRelation: "mysteries";
            referencedColumns: ["id"];
          },
        ];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      [_ in never]: never;
    };
    Enums: {
      [_ in never]: never;
    };
    CompositeTypes: {
      [_ in never]: never;
    };
  };
};

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">;

type DefaultSchema = DatabaseWithoutInternals[Extract<
  keyof Database,
  "public"
>];

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R;
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R;
      }
      ? R
      : never
    : never;

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I;
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I;
      }
      ? I
      : never
    : never;

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U;
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U;
      }
      ? U
      : never
    : never;

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never;

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never;

export const Constants = {
  public: {
    Enums: {},
  },
} as const;
