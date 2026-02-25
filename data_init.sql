-- יצירת טבלת התמונות
CREATE TABLE panoramas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url TEXT NOT NULL,
  storage_path TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- אפשור הרשאות גישה מלאות לטבלה (MVP מהיר)
ALTER TABLE panoramas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public access to panoramas" ON panoramas FOR ALL USING (true) WITH CHECK (true);

-- יצירת באקט אחסון ציבורי לתמונות
INSERT INTO storage.buckets (id, name, public) VALUES ('panoramas_bucket', 'panoramas_bucket', true);

-- מתן הרשאות גישה מלאות לבאקט
CREATE POLICY "Allow public access to storage" ON storage.objects FOR ALL USING (bucket_id = 'panoramas_bucket') WITH CHECK (bucket_id = 'panoramas_bucket');
