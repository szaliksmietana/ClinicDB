--------------------------------------------------------------------------------------
--- TRIGGER DEFINITION
--- trg_prevent_employee_overlap ON tbl_appointments FOR INSERT
--- CREATED BY: Kacper Wardziński
--------------------------------------------------------------------------------------
-- Wyzwalacz sprawdza, czy pracownik nie ma już zaplanowanej wizyty w danym czasie.
-- Uruchamiany automatycznie po dodaniu nowego rekordu do tabeli tbl_appointments.
-- Jeżeli wykryje nakładanie się terminów, przerywa transakcję i zgłasza błąd.
--
-- Główne operacje:
-- 1. Dla każdego nowo wstawionego wiersza sprawdza, czy istnieje już w tabeli tbl_appointments
--    inna wizyta dla tego samego pracownika o statusie 'scheduled', która koliduje czasowo.
-- 2. Kolizja zachodzi, jeśli:
--      - początek nowej wizyty < koniec istniejącej wizyty
--      - oraz koniec nowej wizyty > początek istniejącej wizyty
-- 3. Jeśli konflikt zostanie wykryty, transakcja jest przerywana (ROLLBACK), a komunikat
--    błędu informuje o nałożeniu się wizyt.
--
-- parametry wejściowe:
-- Brak bezpośrednich parametrów. Wyzwalacz analizuje dane z pseudo-tabeli INSERTED.
--
-- parametry wyjściowe/zwracane wartości:
-- Brak. W przypadku kolizji wizyta nie zostaje zapisana do tabeli, a zgłaszany jest błąd.
--
-- /*
-- Przykład użycia
-- INSERT INTO tbl_appointments (employee_id, patient_id, appointment_date, duration_minutes, status)
-- VALUES (2, 5, '2025-07-02 10:00:00', 30, 'scheduled')
--
-- Jeśli pracownik 2 ma już wizytę o tej porze:
-- Transakcja zostanie przerwana, a komunikat zwróci informację o konflikcie.
--
-- Wynik działania
-- Poprawne dodanie rekordu, jeżeli termin nie koliduje z inną wizytą.
-- Transakcja przerwana, jeśli wykryto nakładanie się wizyt.
......................................................................................


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
         AND a.appointment_id != i.appointment_id
    )
    BEGIN
        RAISERROR('Termin wizyty jest już zajęty przez innego pacjenta.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
