-- Procedura planowania wizyty
CREATE PROCEDURE up_schedule_appointment
    @in_patient_id BIGINT,
    @in_employee_id BIGINT,
    @in_date DATETIME2,
    @in_duration INT,
    @in_notes NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO tbl_appointments (
        patient_id, employee_id, appointment_date, duration_minutes, status, notes
    ) VALUES (
        @in_patient_id, @in_employee_id, @in_date, @in_duration, 'scheduled', @in_notes
    )
END;
