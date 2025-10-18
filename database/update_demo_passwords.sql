-- Update demo users' password hashes to bcrypt using pgcrypto
-- Run this in your Postgres/Supabase SQL editor in the same database that contains the `users` table.
-- It will set the passwords for the demo accounts to the values shown below.

BEGIN;

-- Admins
UPDATE users
SET password_hash = crypt('admin123', gen_salt('bf'))
WHERE email IN ('admin1@medsync.com', 'admin2@medsync.com');

-- Doctors
UPDATE users
SET password_hash = crypt('doctor123', gen_salt('bf'))
WHERE email IN ('doctor1@medsync.com', 'doctor2@medsync.com');

-- Patients
UPDATE users
SET password_hash = crypt('patient123', gen_salt('bf'))
WHERE email IN ('patient1@medsync.com', 'patient2@medsync.com');

-- Pharmacies
UPDATE users
SET password_hash = crypt('pharmacy123', gen_salt('bf'))
WHERE email IN ('pharmacy1@medsync.com', 'pharmacy2@medsync.com');

COMMIT;

-- Quick verification: list the demo users and their password hash (hashed values only)
SELECT email, role, substring(password_hash from 1 for 60) AS password_hash_preview
FROM users
WHERE email LIKE '%@medsync.com';

-- Notes:
-- - This uses the pgcrypto extension's bcrypt implementation. Your database must have
--   the extension available (the combined schema file already contains CREATE EXTENSION IF NOT EXISTS pgcrypto).
-- - After running this, use the regular login endpoint with the plaintext passwords:
--     admin / admin123
--     doctor / doctor123
--     patient / patient123
--     pharmacy / pharmacy123
-- - If you prefer to set different passwords, edit the quoted plaintexts above before running.
