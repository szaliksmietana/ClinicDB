CREATE TRIGGER trg_prevent_employee_overlap
ON tbl_appointments
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN tbl_appointments a
          ON a.employee_id = i.employee_id
          AND a.status = 'scheduled'
          AND (
              i.appointment_date BETWEEN a.appointment_date AND DATEADD(MINUTE, a.duration_minutes, a.appointment_date)
              OR DATEADD(MINUTE, i.duration_minutes, i.appointment_date) > a.appointment_date
                 AND i.appointment_date < DATEADD(MINUTE, a.duration_minutes, a.appointment_date)
          )
    )
    BEGIN
        RAISERROR('Pracownik ma już zaplanowaną wizytę w tym czasie.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
