-- Hospital-Pharmacy Collaboration Tables

CREATE TABLE hospital_pharmacy_links (
  link_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hospital_id UUID NOT NULL REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
  pharmacy_id UUID NOT NULL REFERENCES pharmacies(pharmacy_id) ON DELETE CASCADE,
  collaboration_status VARCHAR(50) DEFAULT 'pending' CHECK (collaboration_status IN ('active', 'pending', 'inactive')),
  established_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(hospital_id, pharmacy_id)
);

CREATE INDEX idx_hospital_pharmacy_links_hospital_id ON hospital_pharmacy_links(hospital_id);
CREATE INDEX idx_hospital_pharmacy_links_pharmacy_id ON hospital_pharmacy_links(pharmacy_id);
