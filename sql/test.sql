-- ============================================
-- HospitalTrack • End-to-End Test
-- ============================================

SET SERVEROUTPUT ON;

-- 1) Auto schedule appointment
BEGIN
  Auto_Schedule(1, SYSDATE+1);
  DBMS_OUTPUT.PUT_LINE('Appointment scheduled for patient 1.');
END;
/
SELECT * FROM Appointments;

-- 2) Record prescription
BEGIN
  Record_Prescription(1, 101, 'Aspirin', 10);
  DBMS_OUTPUT.PUT_LINE('Prescription recorded for patient 1.');
END;
/
SELECT * FROM Prescriptions WHERE patient_id = 1;

-- 3) Validate stock reduction
SELECT drug_name, stock_left FROM Prescriptions WHERE drug_name = 'Aspirin';
