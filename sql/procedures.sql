-- ============================================
-- HospitalTrack • Prescription Procedure
-- ============================================

-- Drop if present
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE Record_Prescription'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4043 THEN RAISE; END IF; END;
/

-- Record_Prescription:
--   Creates a prescription and updates stock
CREATE OR REPLACE PROCEDURE Record_Prescription (
  p_patient_id IN NUMBER,
  p_doctor_id  IN NUMBER,
  p_drug_name  IN VARCHAR2,
  p_quantity   IN NUMBER
) AS
  v_rx_id NUMBER;
  v_stock NUMBER;
BEGIN
  IF p_quantity <= 0 THEN
    RAISE_APPLICATION_ERROR(-22000, 'Quantity must be positive');
  END IF;

  -- Simplified: assume each drug has stock tracked per name
  SELECT NVL(SUM(stock_left),0) INTO v_stock FROM Prescriptions WHERE drug_name = p_drug_name;

  IF v_stock < p_quantity THEN
    RAISE_APPLICATION_ERROR(-22001, 'Insufficient stock for ' || p_drug_name);
  END IF;

  v_rx_id := NVL((SELECT MAX(rx_id) FROM Prescriptions),0)+1;
  INSERT INTO Prescriptions (rx_id, patient_id, doctor_id, drug_name, quantity, stock_left, prescribed_at)
  VALUES (v_rx_id, p_patient_id, p_doctor_id, p_drug_name, p_quantity, v_stock - p_quantity, SYSDATE);

  COMMIT;
END Record_Prescription;
/
SHOW ERRORS;
