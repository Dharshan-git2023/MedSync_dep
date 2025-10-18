-- Prescription Management Tables

CREATE TABLE prescriptions (
  prescription_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id UUID REFERENCES doctors(doctor_id) ON DELETE SET NULL,
  record_id UUID REFERENCES medical_records(record_id) ON DELETE SET NULL,
  prescription_date DATE NOT NULL,
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'filled', 'cancelled')),
  pharmacy_id UUID REFERENCES pharmacies(pharmacy_id) ON DELETE SET NULL,
  medications JSONB DEFAULT '[]',
  total_cost DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_prescriptions_patient_id ON prescriptions(patient_id);
CREATE INDEX idx_prescriptions_doctor_id ON prescriptions(doctor_id);
CREATE INDEX idx_prescriptions_pharmacy_id ON prescriptions(pharmacy_id);
CREATE INDEX idx_prescriptions_status ON prescriptions(status);
CREATE INDEX idx_prescriptions_prescription_date ON prescriptions(prescription_date);
