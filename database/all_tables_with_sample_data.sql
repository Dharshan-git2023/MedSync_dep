-- Combined schema and sample data for MedSync
-- Created: 2025-10-18
-- Notes:
--  - Uses explicit UUID values for sample rows so foreign keys can reference them.
--  - This file contains the CREATE TABLE statements (from 01-11) followed by
--    INSERT statements (two sample rows per table).

-- To run in Supabase/Postgres: paste into SQL editor and execute.

/* ------------------------- */
/*  CREATE TABLE DEFINITIONS */
/* ------------------------- */

-- Authentication & User Management Tables

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Use TEXT ids for easier sample data (defaults still generate UUID strings when omitted)
CREATE TABLE IF NOT EXISTS users (
  user_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('admin', 'doctor', 'patient', 'pharmacy')),
  full_name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

CREATE TABLE IF NOT EXISTS sessions (
  session_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  user_id TEXT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  refresh_token VARCHAR(500),
  access_token_expires_at TIMESTAMP,
  device_info VARCHAR(255),
  ip_address VARCHAR(45),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT true
);

CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_sessions_is_active ON sessions(is_active);

-- Hospital Management Tables

CREATE TABLE IF NOT EXISTS hospitals (
  hospital_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  hospital_name VARCHAR(255) NOT NULL,
  address TEXT NOT NULL,
  contact_number VARCHAR(20),
  license_number VARCHAR(100) UNIQUE NOT NULL,
  admin_user_id TEXT REFERENCES users(user_id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_hospitals_admin_user_id ON hospitals(admin_user_id);
CREATE INDEX IF NOT EXISTS idx_hospitals_license_number ON hospitals(license_number);

-- Doctor Management Tables

CREATE TABLE IF NOT EXISTS doctors (
  doctor_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  user_id TEXT NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
  specialization VARCHAR(255) NOT NULL,
  license_number VARCHAR(100) UNIQUE NOT NULL,
  hospital_id TEXT REFERENCES hospitals(hospital_id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_doctors_user_id ON doctors(user_id);
CREATE INDEX IF NOT EXISTS idx_doctors_hospital_id ON doctors(hospital_id);
CREATE INDEX IF NOT EXISTS idx_doctors_license_number ON doctors(license_number);

-- Patient Management Tables

CREATE TABLE IF NOT EXISTS patients (
  patient_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  user_id TEXT NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
  date_of_birth DATE,
  gender VARCHAR(20),
  blood_group VARCHAR(10),
  address TEXT,
  emergency_contact VARCHAR(255),
  assigned_doctor_id TEXT REFERENCES doctors(doctor_id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_patients_user_id ON patients(user_id);
CREATE INDEX IF NOT EXISTS idx_patients_assigned_doctor_id ON patients(assigned_doctor_id);

CREATE TABLE IF NOT EXISTS medical_records (
  record_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  patient_id TEXT NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id TEXT REFERENCES doctors(doctor_id) ON DELETE SET NULL,
  visit_date DATE NOT NULL,
  diagnosis TEXT,
  symptoms TEXT,
  notes TEXT,
  vital_signs JSONB DEFAULT '{}',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_medical_records_patient_id ON medical_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_medical_records_doctor_id ON medical_records(doctor_id);
CREATE INDEX IF NOT EXISTS idx_medical_records_visit_date ON medical_records(visit_date);

-- Pharmacy Management Tables

CREATE TABLE IF NOT EXISTS pharmacies (
  pharmacy_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  user_id TEXT NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
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

CREATE INDEX IF NOT EXISTS idx_pharmacies_user_id ON pharmacies(user_id);
CREATE INDEX IF NOT EXISTS idx_pharmacies_license_number ON pharmacies(license_number);

CREATE TABLE IF NOT EXISTS inventory (
  inventory_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  pharmacy_id TEXT NOT NULL REFERENCES pharmacies(pharmacy_id) ON DELETE CASCADE,
  medication_name VARCHAR(255) NOT NULL,
  stock_quantity INTEGER NOT NULL DEFAULT 0,
  unit_price DECIMAL(10, 2) NOT NULL,
  expiry_date DATE,
  available_for_online_order BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_inventory_pharmacy_id ON inventory(pharmacy_id);
CREATE INDEX IF NOT EXISTS idx_inventory_medication_name ON inventory(medication_name);

-- Prescription Management Tables

CREATE TABLE IF NOT EXISTS prescriptions (
  prescription_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  patient_id TEXT NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id TEXT REFERENCES doctors(doctor_id) ON DELETE SET NULL,
  record_id TEXT REFERENCES medical_records(record_id) ON DELETE SET NULL,
  prescription_date DATE NOT NULL,
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'filled', 'cancelled')),
  pharmacy_id TEXT REFERENCES pharmacies(pharmacy_id) ON DELETE SET NULL,
  medications JSONB DEFAULT '[]',
  total_cost DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_prescriptions_patient_id ON prescriptions(patient_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_doctor_id ON prescriptions(doctor_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_pharmacy_id ON prescriptions(pharmacy_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_status ON prescriptions(status);
CREATE INDEX IF NOT EXISTS idx_prescriptions_prescription_date ON prescriptions(prescription_date);

-- Appointment System Tables

CREATE TABLE IF NOT EXISTS appointments (
  appointment_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  patient_id TEXT NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id TEXT NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  status VARCHAR(50) DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'completed', 'cancelled')),
  reason TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_appointments_patient_id ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_doctor_id ON appointments(doctor_id);
CREATE INDEX IF NOT EXISTS idx_appointments_appointment_date ON appointments(appointment_date);
CREATE INDEX IF NOT EXISTS idx_appointments_status ON appointments(status);

-- Online Delivery System Tables

CREATE TABLE IF NOT EXISTS orders (
  order_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  prescription_id TEXT NOT NULL REFERENCES prescriptions(prescription_id) ON DELETE CASCADE,
  patient_id TEXT NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
  pharmacy_id TEXT REFERENCES pharmacies(pharmacy_id) ON DELETE SET NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivery_address TEXT NOT NULL,
  delivery_phone VARCHAR(20) NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50) CHECK (payment_method IN ('online', 'cod')),
  payment_status VARCHAR(50) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid')),
  order_status VARCHAR(50) DEFAULT 'placed' CHECK (order_status IN ('placed', 'confirmed', 'packed', 'out_for_delivery', 'delivered', 'cancelled')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_orders_prescription_id ON orders(prescription_id);
CREATE INDEX IF NOT EXISTS idx_orders_patient_id ON orders(patient_id);
CREATE INDEX IF NOT EXISTS idx_orders_pharmacy_id ON orders(pharmacy_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_status ON orders(order_status);

CREATE TABLE IF NOT EXISTS deliveries (
  delivery_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  order_id TEXT NOT NULL UNIQUE REFERENCES orders(order_id) ON DELETE CASCADE,
  delivery_person_name VARCHAR(255),
  delivery_person_phone VARCHAR(20),
  pickup_time TIMESTAMP,
  estimated_delivery_time TIMESTAMP,
  actual_delivery_time TIMESTAMP,
  current_location JSONB DEFAULT '{}',
  status VARCHAR(50) DEFAULT 'assigned' CHECK (status IN ('assigned', 'picked_up', 'in_transit', 'delivered')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_deliveries_order_id ON deliveries(order_id);
CREATE INDEX IF NOT EXISTS idx_deliveries_status ON deliveries(status);

CREATE TABLE IF NOT EXISTS delivery_tracking (
  tracking_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  delivery_id TEXT NOT NULL REFERENCES deliveries(delivery_id) ON DELETE CASCADE,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  location JSONB DEFAULT '{}',
  status_update VARCHAR(255),
  notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_delivery_tracking_delivery_id ON delivery_tracking(delivery_id);
CREATE INDEX IF NOT EXISTS idx_delivery_tracking_timestamp ON delivery_tracking(timestamp);

-- Hospital-Pharmacy Collaboration Tables

CREATE TABLE IF NOT EXISTS hospital_pharmacy_links (
  link_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  hospital_id TEXT NOT NULL REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
  pharmacy_id TEXT NOT NULL REFERENCES pharmacies(pharmacy_id) ON DELETE CASCADE,
  collaboration_status VARCHAR(50) DEFAULT 'pending' CHECK (collaboration_status IN ('active', 'pending', 'inactive')),
  established_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(hospital_id, pharmacy_id)
);

CREATE INDEX IF NOT EXISTS idx_hospital_pharmacy_links_hospital_id ON hospital_pharmacy_links(hospital_id);
CREATE INDEX IF NOT EXISTS idx_hospital_pharmacy_links_pharmacy_id ON hospital_pharmacy_links(pharmacy_id);

-- AI Chatbot Integration Tables

CREATE TABLE IF NOT EXISTS ai_conversations (
  conversation_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  user_id TEXT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_message_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  conversation_type VARCHAR(50) CHECK (conversation_type IN ('patient_assistant', 'doctor_assistant')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_ai_conversations_user_id ON ai_conversations(user_id);

CREATE TABLE IF NOT EXISTS ai_messages (
  message_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  conversation_id TEXT NOT NULL REFERENCES ai_conversations(conversation_id) ON DELETE CASCADE,
  sender VARCHAR(50) CHECK (sender IN ('user', 'ai')),
  message_text TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  context_data JSONB DEFAULT '{}'
);

CREATE INDEX IF NOT EXISTS idx_ai_messages_conversation_id ON ai_messages(conversation_id);
CREATE INDEX IF NOT EXISTS idx_ai_messages_timestamp ON ai_messages(timestamp);

-- System Analytics Tables

CREATE TABLE IF NOT EXISTS system_stats (
  stat_id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  date DATE NOT NULL,
  total_patients INTEGER DEFAULT 0,
  total_doctors INTEGER DEFAULT 0,
  total_appointments INTEGER DEFAULT 0,
  prescriptions_filled INTEGER DEFAULT 0,
  active_users INTEGER DEFAULT 0,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(date)
);

CREATE INDEX IF NOT EXISTS idx_system_stats_date ON system_stats(date);

/* ------------------------- */
/*     SAMPLE INSERT DATA    */
/* ------------------------- */

-- NOTE: explicit UUIDs are used so that related rows can reference them.

-- Users (2 per role to ensure FK coverage)
INSERT INTO users (user_id, email, password_hash, role, full_name, phone_number, is_active)
VALUES
  ('u_admin1','admin1@medsync.com','$2b$12$4IvMw8hevF2QOHC/m8b2iOF1RO8NPqTRssZzjFOJrSzy0NnQQk3qC','admin','Admin One','+10000000001',true),
  ('u_admin2','admin2@medsync.com','$2b$12$4IvMw8hevF2QOHC/m8b2iOF1RO8NPqTRssZzjFOJrSzy0NnQQk3qC','admin','Admin Two','+10000000002',true),
  ('u_doc1','doctor1@medsync.com','$2b$12$3p6X/OmXOKIXNx9IG/bc2eoZtWMoRauWD2rWun4Bag1inKk2qAIFe','doctor','Dr. Alice Smith','+10000000011',true),
  ('u_doc2','doctor2@medsync.com','$2b$12$3p6X/OmXOKIXNx9IG/bc2eoZtWMoRauWD2rWun4Bag1inKk2qAIFe','doctor','Dr. Bob Jones','+10000000012',true),
  ('u_pat1','patient1@medsync.com','$2b$12$LsVcHxFvBbv8hB6g3m7TAOt4iy/jLmYcyds104g8b/th9uIisCDT2','patient','Patient One','+10000000021',true),
  ('u_pat2','patient2@medsync.com','$2b$12$LsVcHxFvBbv8hB6g3m7TAOt4iy/jLmYcyds104g8b/th9uIisCDT2','patient','Patient Two','+10000000022',true),
  ('u_phar1','pharmacy1@medsync.com','$2b$12$mJ4/BpzjII.RYdUkIsJOGOFkVSDG.2aF1pkffLA7bJlmKnFLb/nd.','pharmacy','Pharmacy One','+10000000031',true),
  ('u_phar2','pharmacy2@medsync.com','$2b$12$mJ4/BpzjII.RYdUkIsJOGOFkVSDG.2aF1pkffLA7bJlmKnFLb/nd.','pharmacy','Pharmacy Two','+10000000032',true)
ON CONFLICT DO NOTHING;

-- Sessions
INSERT INTO sessions (session_id, user_id, refresh_token, access_token_expires_at, device_info, ip_address, is_active)
VALUES
  ('s1','u_doc1','refresh_token_example_1', now() + interval '1 day','Chrome on Windows','203.0.113.1',true),
  ('s2','u_pat1','refresh_token_example_2', now() + interval '1 day','Safari on iPhone','198.51.100.2',true)
ON CONFLICT DO NOTHING;

-- Hospitals
INSERT INTO hospitals (hospital_id, hospital_name, address, contact_number, license_number, admin_user_id)
VALUES
  ('h1','Central City Hospital','123 Main St, Central City','+14045550101','LIC-CCH-0001',NULL),
  ('h2','Riverside Medical Center','456 River Rd, Riverside','+14045550202','LIC-RMC-0002',NULL)
ON CONFLICT DO NOTHING;

-- Doctors
INSERT INTO doctors (doctor_id, user_id, specialization, license_number, hospital_id)
VALUES
  ('d1','u_doc1','Cardiology','DOC-LIC-1001','h1'),
  ('d2','u_doc2','General Practice','DOC-LIC-1002','h2')
ON CONFLICT DO NOTHING;

-- Patients
INSERT INTO patients (patient_id, user_id, date_of_birth, gender, blood_group, address, emergency_contact, assigned_doctor_id)
VALUES
  ('p1','u_pat1','1990-05-15','female','A+','789 Patient Ln, Central City','+14045559999','d1'),
  ('p2','u_pat2','1985-11-30','male','O-','101 Patient Ave, Riverside','+14045558888','d2')
ON CONFLICT DO NOTHING;

-- Medical Records
INSERT INTO medical_records (record_id, patient_id, doctor_id, visit_date, diagnosis, symptoms, notes, vital_signs)
VALUES
  ('r1','p1','d1','2025-09-01','Hypertension','headache, dizziness','Prescribed medication and follow-up','{"bp": "140/90", "hr": 78}'),
  ('r2','p2','d2','2025-09-15','Seasonal Cold','cough, sore throat','Advised rest and fluids','{"temp": 37.2, "oxygen": 98}')
ON CONFLICT DO NOTHING;

-- Pharmacies
INSERT INTO pharmacies (pharmacy_id, user_id, pharmacy_name, address, license_number, delivery_available, delivery_radius_km, delivery_fee, min_order_for_free_delivery)
VALUES
  ('ph1','u_phar1','Central Pharmacy','10 Pharmacy Blvd, Central City','PHAR-LIC-2001',true,10.00,5.00,50.00),
  ('ph2','u_phar2','Riverside Pharmacy','20 River St, Riverside','PHAR-LIC-2002',false,0.00,0.00,0.00)
ON CONFLICT DO NOTHING;

-- Inventory
INSERT INTO inventory (inventory_id, pharmacy_id, medication_name, stock_quantity, unit_price, expiry_date, available_for_online_order)
VALUES
  ('inv1','ph1','Paracetamol 500mg',200,0.50,'2026-12-31',true),
  ('inv2','ph2','Amoxicillin 250mg',50,1.20,'2025-08-15',true)
ON CONFLICT DO NOTHING;

-- Prescriptions
INSERT INTO prescriptions (prescription_id, patient_id, doctor_id, record_id, prescription_date, status, pharmacy_id, medications, total_cost)
VALUES
  ('pr1','p1','d1','r1','2025-09-01','pending','ph1','[{"name":"Paracetamol","dose":"500mg","quantity":10}]',5.00),
  ('pr2','p2','d2','r2','2025-09-15','pending','ph2','[{"name":"Amoxicillin","dose":"250mg","quantity":14}]',16.80)
ON CONFLICT DO NOTHING;

-- Appointments
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, reason, notes)
VALUES
  ('ap1','p1','d1','2025-10-01','09:30:00','scheduled','Routine check-up',''),
  ('ap2','p2','d2','2025-10-02','14:00:00','scheduled','Follow-up','')
ON CONFLICT DO NOTHING;

-- Orders
INSERT INTO orders (order_id, prescription_id, patient_id, pharmacy_id, delivery_address, delivery_phone, total_amount, payment_method, payment_status, order_status)
VALUES
  ('o1','pr1','p1','ph1','789 Patient Ln, Central City','+14045559999',5.00,'online','paid','delivered'),
  ('o2','pr2','p2','ph2','101 Patient Ave, Riverside','+14045558888',16.80,'cod','pending','placed')
ON CONFLICT DO NOTHING;

-- Deliveries
INSERT INTO deliveries (delivery_id, order_id, delivery_person_name, delivery_person_phone, pickup_time, estimated_delivery_time, actual_delivery_time, current_location, status)
VALUES
  ('del1','o1','John Courier','+14045557777', now() - interval '1 hour', now() + interval '30 minutes', now() - interval '10 minutes','{"lat":40.7128,"lon":-74.0060}','delivered'),
  ('del2','o2','Jane Courier','+14045556666', now(), now() + interval '1 hour', NULL,'{"lat":40.7138,"lon":-74.0050}','assigned')
ON CONFLICT DO NOTHING;

-- Delivery Tracking
INSERT INTO delivery_tracking (tracking_id, delivery_id, timestamp, location, status_update, notes)
VALUES
  ('t1','del1', now() - interval '20 minutes', '{"lat":40.7129,"lon":-74.0061}', 'delivered', 'Left with patient'),
  ('t2','del2', now() - interval '10 minutes', '{"lat":40.7130,"lon":-74.0055}', 'picked_up', 'On the way')
ON CONFLICT DO NOTHING;

-- Hospital-Pharmacy Links
INSERT INTO hospital_pharmacy_links (link_id, hospital_id, pharmacy_id, collaboration_status, established_date)
VALUES
  ('link1','h1','ph1','active','2024-01-01'),
  ('link2','h2','ph2','pending','2025-06-15')
ON CONFLICT DO NOTHING;

-- AI Conversations
INSERT INTO ai_conversations (conversation_id, user_id, conversation_type)
VALUES
  ('conv1','u_pat1','patient_assistant'),
  ('conv2','u_doc1','doctor_assistant')
ON CONFLICT DO NOTHING;

-- AI Messages
INSERT INTO ai_messages (message_id, conversation_id, sender, message_text, context_data)
VALUES
  ('msg1','conv1','user','What are the side effects of Paracetamol?','{}'),
  ('msg2','conv2','ai','Common side effects are nausea and allergic reactions.','{}')
ON CONFLICT DO NOTHING;

-- System Stats
INSERT INTO system_stats (stat_id, date, total_patients, total_doctors, total_appointments, prescriptions_filled, active_users)
VALUES
  ('stat1','2025-10-17',2,2,3,1,4),
  ('stat2','2025-10-18',2,2,4,2,5)
ON CONFLICT DO NOTHING;

-- End of file
