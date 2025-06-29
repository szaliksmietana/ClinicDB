-- Wyzwalacz sprawdzający nakładanie się wizyt pracowników
CREATE TRIGGER trg_prevent_employee_overlap
ON tbl_appointments
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @overlap_count INT
    DECLARE @employee_id BIGINT, @appointment_date DATETIME2, @duration_minutes INT
    
    SELECT @employee_id = employee_id, @appointment_date = appointment_date, @duration_minutes = duration_minutes
    FROM inserted
    
    SELECT @overlap_count = COUNT(*)
    FROM tbl_appointments
    WHERE
        employee_id = @employee_id
        AND status = 'scheduled'
        AND (
            @appointment_date BETWEEN appointment_date AND DATEADD(MINUTE, duration_minutes, appointment_date)
            OR DATEADD(MINUTE, @duration_minutes, @appointment_date) > appointment_date
               AND @appointment_date < DATEADD(MINUTE, duration_minutes, appointment_date)
        )

    IF @overlap_count > 0
    BEGIN
        RAISERROR('Pracownik ma już zaplanowaną wizytę w tym czasie.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
