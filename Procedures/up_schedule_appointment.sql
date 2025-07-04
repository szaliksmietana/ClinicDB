--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_schedule_appointment (@in_patient_id BIGINT, @in_employee_id BIGINT, @in_date DATETIME2, 
--- @in_duration INT, @in_notes NVARCHAR(MAX))
--- CREATED BY: Kacper Wardziński
--------------------------------------------------------------------------------------
-- Procedura planuje wizytę pacjenta w systemie. Dodaje nowy rekord do tabeli tbl_appointments,
-- wskazując pacjenta, pracownika, datę wizyty, czas trwania wizyty oraz dodatkowe notatki.
--
-- parametry wejściowe:
-- @in_patient_id - identyfikator pacjenta, który umawia wizytę
-- @in_employee_id - identyfikator pracownika (np. lekarza), który będzie obsługiwał wizytę
-- @in_date - data i godzina zaplanowanej wizyty
-- @in_duration - czas trwania wizyty w minutach
-- @in_notes - dodatkowe notatki dotyczące wizyty
--
-- parametry wyjściowe/zwracane wartości:
-- Brak wartości wyjściowych, procedura nie zwraca żadnych danych, ale wykonuje operację wstawiania rekordu.
--
--
-- /*
-- Przykład użycia
EXEC up_schedule_appointment 123, 456, '2025-07-01 10:00:00', 30, 'Wizyta kontrolna.'
--
-- Wynik działania
-- Zapisano wizytę dla pacjenta 123 u pracownika 456 na dzień 2025-07-01.
......................................................................................

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
