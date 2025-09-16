-- ============================================
-- HospitalTrack • Schema Definition
-- ============================================

-- Drop in dependency order for clean re-runs
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Prescriptions PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Appointments PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Doctors PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Patients PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

-- Patients: registered individuals
CREATE TABLE Patients (
  patient_id    NUMBER         PRIMARY KEY,
  full_name     VARCHAR2(120)  NOT NULL,
  dob           DATE,
  email         VARCHAR2(160),
  joined_at     DATE DEFAULT SYSDATE
);

-- Doctors: available practitioners
CREATE TABLE Doctors (
  doctor_id     NUMBER         PRIMARY KEY,
  full_name     VARCHAR2(120)  NOT NULL,
  specialty     VARCHAR2(80),
  available     CHAR(1) DEFAULT 'Y' CHECK (available IN ('Y','N'))
);

-- Appointments: patient-doctor visits
CREATE TABLE Appointments (
  appt_id       NUMBER         PRIMARY KEY,
  patient_id    NUMBER         NOT NULL REFERENCES Patients(patient_id),
  doctor_id     NUMBER         NOT NULL REFERENCES Doctors(doctor_id),
  appt_date     DATE           DEFAULT SYSDATE,
  status        VARCHAR2(20)   DEFAULT 'SCHEDULED' CHECK (status IN ('SCHEDULED','COMPLETED','CANCELLED'))
);

-- Prescriptions: medication assignments with stock
CREATE TABLE Prescriptions (
  rx_id         NUMBER         PRIMARY KEY,
  patient_id    NUMBER         NOT NULL REFERENCES Patients(patient_id),
  doctor_id     NUMBER         NOT NULL REFERENCES Doctors(doctor_id),
  drug_name     VARCHAR2(100)  NOT NULL,
  quantity      NUMBER         NOT NULL CHECK (quantity > 0),
  stock_left    NUMBER         NOT NULL,
  prescribed_at DATE DEFAULT SYSDATE
);

-- Indexes for performance
CREATE INDEX idx_appt_doc ON Appointments(doctor_id, appt_date);
CREATE INDEX idx_rx_patient ON Prescriptions(patient_id);
