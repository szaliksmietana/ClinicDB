--------------------------------------------------------------------------------------
--- FUNCTION DEFINITION
--- uf_get_user_type (@uid BIGINT) RETURNS NVARCHAR(20)
--- CREATED BY: Mateusz Wypchło
--------------------------------------------------------------------------------------
-- Funkcja zwraca typ użytkownika na podstawie jego identyfikatora. Sprawdza, czy użytkownik
-- znajduje się w tabeli pracowników (employee), pacjentów (patient), czy też w żadnej z nich (unknown).
--
-- parametry wejściowe:
-- @uid - identyfikator użytkownika, którego typ ma zostać zwrócony
--
-- parametry wyjściowe/zwracane wartości:
-- Zwracana wartość: typ użytkownika w formie tekstowej, możliwe wartości:
-- - 'employee' - użytkownik to pracownik
-- - 'patient' - użytkownik to pacjent
-- - 'unknown' - użytkownik nie jest ani pracownikiem, ani pacjentem
--
--
-- /*
-- Przykład użycia
SELECT dbo.uf_get_user_type(123)
--
-- Wynik działania
-- Zwrócono wynik: 'patient'
......................................................................................

CREATE FUNCTION uf_get_user_type(@uid BIGINT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @result NVARCHAR(20)
    
    IF EXISTS (SELECT 1 FROM tbl_employees WHERE user_id = @uid)
        SET @result = 'employee'
    ELSE IF EXISTS (SELECT 1 FROM tbl_patients WHERE user_id = @uid)
        SET @result = 'patient'
    ELSE
        SET @result = 'unknown'
    
    RETURN @result
END;
