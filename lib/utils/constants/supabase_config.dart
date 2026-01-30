/// Supabase configuration constants
class SupabaseConfig {
  // Supabase project URL
  static const String supabaseUrl = 'https://bozcdvpougqpnizzbsqg.supabase.co';
  
  // Supabase anon/public API key
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvemNkdnBvdWdxcG5penpic3FnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU5MDQzNzYsImV4cCI6MjA4MTQ4MDM3Nn0.ih7O9WsR46rA2AshRO953ojZOzAQzPnUniOFUbP6uAQ';
  
  // Storage bucket name
  // IMPORTANT: You must create this bucket in your Supabase dashboard first!
  // Go to: Storage > Create a new bucket
  // Recommended bucket name: 'images' or 'media'
  // Make sure to set it as PUBLIC if you want public access to the images
  static const String storageBucket = 'images';
}

