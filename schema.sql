
-- ============================================================
-- TESLA PHRENDLY PROXY COMMANDER - SUPABASE SCHEMA
-- Run this in your Supabase SQL Editor
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- 1. PROXIES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS proxies (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text,
  location text,
  protocol text DEFAULT 'HTTP',
  host text,
  port text,
  username text,
  password text,
  notes text,
  expiry_date date,
  health_status text DEFAULT 'good',
  speed_ms integer,
  last_check timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- 2. TEAM MEMBERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS team_members (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text NOT NULL,
  whatsapp text NOT NULL,
  device text DEFAULT 'desktop',
  status text DEFAULT 'pending',
  avatar text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 3. ACCESS REQUESTS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS access_requests (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text NOT NULL,
  whatsapp text NOT NULL,
  device text DEFAULT 'desktop',
  status text DEFAULT 'pending',
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 4. BOOKINGS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS bookings (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  proxy_id uuid REFERENCES proxies(id) ON DELETE CASCADE,
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  date date NOT NULL,
  time text,
  notes text,
  is_recurring boolean DEFAULT false,
  parent_booking_id uuid,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 5. EARNINGS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS earnings (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  balance numeric(10,2) DEFAULT 0,
  weekly_goal numeric(10,2) DEFAULT 0,
  daily_goal numeric(10,2) DEFAULT 0,
  whatsapp text,
  updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- 6. NOTICES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS notices (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  type text DEFAULT 'info',
  title text NOT NULL,
  content text NOT NULL,
  zoom_link text,
  mentions text,
  created_by uuid,
  read_by uuid[] DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 7. DOCUMENTS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS documents (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  title text DEFAULT 'Team Guidelines',
  content text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- 8. TUTORIALS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS tutorials (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  title text,
  description text,
  device_type text DEFAULT 'laptop',
  browser text DEFAULT 'adspower',
  image_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- 9. ACTIVE SESSIONS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS active_sessions (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  proxy_id uuid REFERENCES proxies(id) ON DELETE CASCADE,
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  joined_at timestamptz DEFAULT now(),
  left_at timestamptz
);

-- ============================================================
-- 10. LOGS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS logs (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_name text,
  action text,
  ip_address text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 11. SUPPORT TICKETS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS support_tickets (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  problem text NOT NULL,
  whatsapp text,
  urgency text DEFAULT 'medium',
  status text DEFAULT 'open',
  response text,
  resolved_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 12. CHAT MESSAGES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS chat_messages (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  text text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 13. WITHDRAWALS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS withdrawals (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  amount numeric(10,2) NOT NULL,
  method text,
  details text,
  status text DEFAULT 'pending',
  admin_share numeric(10,2) DEFAULT 0,
  user_share numeric(10,2) DEFAULT 0,
  approved_at timestamptz,
  approved_by uuid,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 14. PAYMENT METHODS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS payment_methods (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  method_type text,
  label text,
  value text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 15. LOGIN HISTORY TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS login_history (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_name text,
  success boolean DEFAULT true,
  reason text,
  ip_address text,
  device_info text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 16. AUDIT LOG TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS audit_log (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_name text,
  action text,
  before_state text,
  after_state text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 17. CHALLENGES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS challenges (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  title text NOT NULL,
  goal numeric(10,2) NOT NULL,
  deadline date,
  description text,
  created_by uuid,
  status text DEFAULT 'active',
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 18. ACHIEVEMENTS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS achievements (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  achievement_id text,
  name text,
  icon text,
  description text,
  earned_at timestamptz DEFAULT now()
);

-- ============================================================
-- 19. PROXY WAITLIST TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS proxy_waitlist (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  proxy_id uuid REFERENCES proxies(id) ON DELETE CASCADE,
  user_id uuid REFERENCES team_members(id) ON DELETE CASCADE,
  user_name text,
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- ENABLE REALTIME FOR CRITICAL TABLES
-- ============================================================
ALTER TABLE bookings REPLICA IDENTITY FULL;
ALTER TABLE proxies REPLICA IDENTITY FULL;
ALTER TABLE active_sessions REPLICA IDENTITY FULL;
ALTER TABLE chat_messages REPLICA IDENTITY FULL;
ALTER TABLE support_tickets REPLICA IDENTITY FULL;

-- ============================================================
-- INSERT DEFAULT DATA
-- ============================================================

-- Insert default admin user (login with name: admin, whatsapp: admin123)
INSERT INTO team_members (name, whatsapp, device, status)
VALUES ('Admin', 'admin123', 'desktop', 'admin')
ON CONFLICT DO NOTHING;

-- Insert sample proxy
INSERT INTO proxies (name, location, protocol, host, port, username, password, notes)
VALUES (
  'US Proxy 1', 
  'New York, USA', 
  'HTTP', 
  'proxy.example.com', 
  '8080', 
  'user1', 
  'pass1',
  'Sample proxy for testing'
)
ON CONFLICT DO NOTHING;

-- Insert default documents
INSERT INTO documents (title, content)
VALUES (
  'Team Guidelines',
  'Welcome to Tesla Phrendly Proxy Commander!

1. Always use the assigned proxy for your shift
2. Maximum 2 users per proxy
3. Book your time slots in advance
4. Report any issues immediately via Support
5. Keep your earnings goals updated

Contact admin for any questions.'
)
ON CONFLICT DO NOTHING;

-- ============================================================
-- ENABLE ROW LEVEL SECURITY (OPTIONAL - DISABLE FOR TESTING)
-- ============================================================
-- Uncomment below to enable RLS after testing
/*
ALTER TABLE team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE earnings ENABLE ROW LEVEL SECURITY;
ALTER TABLE withdrawals ENABLE ROW LEVEL SECURITY;

-- Example policy: allow anon read access for testing
CREATE POLICY "Allow anon read" ON team_members FOR SELECT TO anon USING (true);
CREATE POLICY "Allow anon read" ON bookings FOR SELECT TO anon USING (true);
CREATE POLICY "Allow anon read" ON earnings FOR SELECT TO anon USING (true);
CREATE POLICY "Allow anon read" ON proxies FOR SELECT TO anon USING (true);
*/

-- ============================================================
-- SCHEMA SETUP COMPLETE
-- ============================================================
