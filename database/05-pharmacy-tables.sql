-- Pharmacy Management Tables

CREATE TABLE pharmacies (
  pharmacy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
  pharmacy_name VARCHAR(255) NOT NULL,
  address TEXT NOT NULL,
  license_number VARCHAR(100) UNIQUE NOT NULL,
  delivery_available BOOLEAN DEFAULT false,
  delivery_radius_km DECIMAL(5, 2),
  delivery_fee DECIMAL(10, 2),
  min_order_for_free_delivery DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_pharmacies_user_id ON pharmacies(user_id);
CREATE INDEX idx_pharmacies_license_number ON pharmacies(license_number);

CREATE TABLE inventory (
  inventory_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pharmacy_id UUID NOT NULL REFERENCES pharmacies(pharmacy_id) ON DELETE CASCADE,
  medication_name VARCHAR(255) NOT NULL,
  stock_quantity INTEGER NOT NULL DEFAULT 0,
  unit_price DECIMAL(10, 2) NOT NULL,
  expiry_date DATE,
  available_for_online_order BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_inventory_pharmacy_id ON inventory(pharmacy_id);
CREATE INDEX idx_inventory_medication_name ON inventory(medication_name);
