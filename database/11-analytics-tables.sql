-- System Analytics Tables

CREATE TABLE system_stats (
  stat_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date DATE NOT NULL,
  total_patients INTEGER DEFAULT 0,
  total_doctors INTEGER DEFAULT 0,
  total_appointments INTEGER DEFAULT 0,
  prescriptions_filled INTEGER DEFAULT 0,
  active_users INTEGER DEFAULT 0,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(date)
);

CREATE INDEX idx_system_stats_date ON system_stats(date);
