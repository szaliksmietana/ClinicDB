CREATE OR ALTER TRIGGER trg_prevent_overlapping_appointments
ON tbl_appointments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN tbl_appointments a
          ON i.employee_id = a.employee_id
         AND a.status = 'scheduled'
         AND i.status = 'scheduled'
         AND (
             i.appointment_date < DATEADD(MINUTE, a.duration_minutes, a.appointment_date)
             AND DATEADD(MINUTE, i.duration_minutes, i.appointment_date) > a.appointment_date
         )
         AND a.appointment_id != i.appointment_id -- wyklucz sam siebie
    )
    BEGIN
        RAISERROR('Termin wizyty jest już zajęty przez innego pacjenta.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
