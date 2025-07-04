--------------------------------------------------------------------------------------
--- TRIGGER DEFINITION
--- trg_check_position_validity ON tbl_employees FOR INSERT, UPDATE
--- CREATED BY: Mateusz Wypchło
--------------------------------------------------------------------------------------
-- Wyzwalacz weryfikuje poprawność wartości stanowiska przypisanego pracownikowi.
-- Uruchamiany automatycznie po dodaniu lub aktualizacji rekordu w tabeli tbl_employees.
-- Jeżeli wstawiony lub zmodyfikowany rekord zawiera nieistniejące stanowisko (position_id),
-- transakcja zostaje przerwana, a zgłaszany jest błąd.
--
-- Główne operacje:
-- 1. Sprawdza, czy dla każdego wstawianego lub aktualizowanego rekordu istnieje odpowiadający wpis
--    w tabeli tbl_positions o zadanym position_id.
-- 2. W przypadku, gdy nie znajdzie powiązanego stanowiska (LEFT JOIN zwraca NULL),
--    przerywa transakcję i zgłasza błąd informujący o nieprawidłowym stanowisku.
--
-- parametry wejściowe:
-- Brak bezpośrednich parametrów. Wyzwalacz analizuje dane z pseudo-tabeli INSERTED.
--
-- parametry wyjściowe/zwracane wartości:
-- Brak. W przypadku wykrycia nieprawidłowego stanowiska operacja INSERT lub UPDATE
-- zostaje wycofana (ROLLBACK), a użytkownik otrzymuje komunikat o błędzie.
--
-- /*
-- Przykład użycia
-- INSERT INTO tbl_employees (user_id, position_id) VALUES (123, 999);
--
-- Jeśli nie istnieje stanowisko o ID 999:
-- Transakcja zostanie przerwana, a zgłoszony zostanie błąd: "Nieprawidłowa wartość stanowiska (position_id)."
--
-- Wynik działania
-- Poprawne dodanie/aktualizacja pracownika, jeżeli stanowisko istnieje w tbl_positions.
-- Transakcja przerwana, jeśli stanowisko nie istnieje.
......................................................................................

CREATE OR ALTER TRIGGER trg_check_position_validity
ON tbl_employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN tbl_positions p ON i.position_id = p.position_id
        WHERE p.position_id IS NULL
    )
    BEGIN
        RAISERROR('Nieprawidłowa wartość stanowiska (position_id).', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
