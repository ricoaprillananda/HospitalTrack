-- ============================================
-- HospitalTrack • Cursor for Auto-Scheduling
-- ============================================

-- Drop if present
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE Auto_Schedule'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4043 THEN RAISE; END IF; END;
/

-- Auto_Schedule:
--   Finds the first available doctor and books an appointment
CREATE OR REPLACE PROCEDURE Auto_Schedule (
  p_patient_id IN NUMBER,
  p_date       IN DATE DEFAULT SYSDATE
) AS
  CURSOR c_doctors IS
    SELECT doctor_id
      FROM Doctors
     WHERE available = 'Y'
     ORDER BY doctor_id;

  v_doc_id Doctors.doctor_id%TYPE;
  v_appt_id NUMBER;
BEGIN
  OPEN c_doctors;
  FETCH c_doctors INTO v_doc_id;
  IF c_doctors%NOTFOUND THEN
    RAISE_APPLICATION_ERROR(-21000, 'No available doctors');
  END IF;
  CLOSE c_doctors;

  v_appt_id := NVL((SELECT MAX(appt_id) FROM Appointments),0)+1;
  INSERT INTO Appointments (appt_id, patient_id, doctor_id, appt_date, status)
  VALUES (v_appt_id, p_patient_id, v_doc_id, p_date, 'SCHEDULED');

  COMMIT;
END Auto_Schedule;
/
SHOW ERRORS;
