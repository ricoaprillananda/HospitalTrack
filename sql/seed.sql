-- ============================================
-- HospitalTrack • Sample Data
-- ============================================

-- Patients
INSERT INTO Patients (patient_id, full_name, dob, email) VALUES (1, 'Alice Johnson', DATE '1990-05-10', 'alice@example.com');
INSERT INTO Patients (patient_id, full_name, dob, email) VALUES (2, 'Brian Lee', DATE '1985-08-20', 'brian@example.com');

-- Doctors
INSERT INTO Doctors (doctor_id, full_name, specialty, available) VALUES (101, 'Dr. Smith', 'Cardiology', 'Y');
INSERT INTO Doctors (doctor_id, full_name, specialty, available) VALUES (102, 'Dr. Gomez', 'Neurology', 'Y');

-- Prescriptions initial stock (demo)
INSERT INTO Prescriptions (rx_id, patient_id, doctor_id, drug_name, quantity, stock_left, prescribed_at)
VALUES (1001, 1, 101, 'Aspirin', 0, 100, SYSDATE);

COMMIT;
