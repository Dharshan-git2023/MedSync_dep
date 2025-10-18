-- Hospital Management Tables

CREATE TABLE hospitals (
  hospital_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hospital_name VARCHAR(255) NOT NULL,
  address TEXT NOT NULL,
  contact_number VARCHAR(20),
  license_number VARCHAR(100) UNIQUE NOT NULL,
  admin_user_id UUID REFERENCES users(user_id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_hospitals_admin_user_id ON hospitals(admin_user_id);
CREATE INDEX idx_hospitals_license_number ON hospitals(license_number);
