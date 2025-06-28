CREATE VIEW v_upcoming_appointments AS
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.duration_minutes,
    a.status,
    p.user_id AS patient_id,
    CONCAT(pat.first_name, ' ', pat.last_name) AS patient_name,
    e.user_id AS employee_id,
    CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
    a.notes
FROM appointments a
JOIN users pat ON a.patient_id = pat.user_id
JOIN patients p ON p.user_id = pat.user_id
JOIN users emp ON a.employee_id = emp.user_id
JOIN employees e ON e.user_id = emp.user_id
WHERE a.status = 'scheduled' AND a.appointment_date >= NOW()
ORDER BY a.appointment_date;
