-- ============================================
-- HospitalTrack • Triggers and Optimizations
-- ============================================

-- Example materialized view for quick appointment lookup
BEGIN EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW mv_doctor_schedule'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -12003 THEN RAISE; END IF; END;
/

CREATE MATERIALIZED VIEW mv_doctor_schedule
BUILD IMMEDIATE
REFRESH COMPLETE
AS
SELECT d.doctor_id, d.full_name, a.appt_date, a.status
  FROM Doctors d
  LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id;
