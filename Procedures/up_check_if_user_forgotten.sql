--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_reset_user_password (@uid BIGINT, @new_plain_password NVARCHAR(100))
--- CREATED BY: Mateusz Wypchło
--------------------------------------------------------------------------------------
-- Procedura resetuje hasło użytkownika w systemie. Wykonuje aktualizację hasła w tabeli tbl_users
-- na nowe, zaszyfrowane hasło, przy użyciu algorytmu SHA-256.
--
-- parametry wejściowe:
-- @uid - identyfikator użytkownika, którego hasło ma zostać zresetowane
-- @new_plain_password - nowe hasło użytkownika w formie jawnej, które ma zostać zapisane
--
-- parametry wyjściowe/zwracane wartości:
-- Brak wartości wyjściowych, procedura nie zwraca żadnych danych, ale wykonuje operację aktualizacji hasła.
--
--
-- /*
-- Przykład użycia
EXEC up_reset_user_password 123, 'noweHaslo123'
--
-- Wynik działania
-- Zaktualizowano hasło użytkownika o identyfikatorze 123.
......................................................................................

CREATE PROCEDURE up_check_if_user_forgotten
    @uid BIGINT
AS
BEGIN
    SELECT is_forgotten, random_data
    FROM tbl_forgottenusers
    WHERE user_id = @uid
END;
