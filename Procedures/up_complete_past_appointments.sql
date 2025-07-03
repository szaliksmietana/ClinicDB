--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_complete_past_appointments
--- CREATED BY: Filip Szymański
--------------------------------------------------------------------------------------
-- Procedura aktualizuje status wizyt w tabeli tbl_appointments, oznaczając jako
-- „completed” wszystkie te wizyty, których planowany czas już minął.
--
-- Działanie procedury obejmuje:
-- 1. Sprawdzenie wizyt o statusie „scheduled”.
-- 2. Porównanie daty i czasu zakończenia wizyty (appointment_date + duration_minutes)
--    z aktualnym czasem systemowym.
-- 3. Zmianę statusu na „completed” dla wizyt, które się już zakończyły.
--
-- Parametry wejściowe:
-- Brak
--
-- Parametry wyjściowe / zwracane wartości:
-- Brak bezpośrednich parametrów wyjściowych. Procedura wykonuje aktualizację danych.
--
-- Przykład użycia:
-- EXEC up_complete_past_appointments
--
-- Wynik działania:
-- Wszystkie wizyty o statusie „scheduled”, których czas zakończenia minął, zostaną oznaczone jako „completed”.
--------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE up_complete_past_appointments
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE tbl_appointments
    SET status = 'completed'
    WHERE status = 'scheduled'
      AND DATEADD(MINUTE, duration_minutes, appointment_date) < SYSDATETIME();
END;
