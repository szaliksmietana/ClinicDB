--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_check_if_user_forgotten (@uid BIGINT)
--- CREATED BY: Oskar Sobczak
--------------------------------------------------------------------------------------
-- Procedura sprawdza, czy użytkownik został oznaczony jako zapomniany.
-- Wykonuje zapytanie do tabeli tbl_forgottenusers i zwraca status zapomnienia użytkownika oraz dodatkowe dane.
--
-- parametry wejściowe:
-- @uid - identyfikator użytkownika, który ma zostać sprawdzony
--
-- parametry wyjściowe/zwracane wartości:
-- Zwracane dane:
-- is_forgotten - informacja, czy użytkownik jest zapomniany (1 - zapomniany, 0 - nie zapomniany)
-- random_data - dodatkowe dane związane z użytkownikiem (możliwość ich wykorzystania w przyszłości)
--
--
-- /*
-- Przykład użycia
DECLARE @is_forgotten BIT
EXEC up_check_if_user_forgotten 123
--
-- Wynik działania
-- Zwrócono wynik: is_forgotten = 1, random_data = 'dane'
......................................................................................

CREATE PROCEDURE up_reset_user_password
    @uid BIGINT,
    @new_plain_password NVARCHAR(100)
AS
BEGIN
    UPDATE tbl_users
    SET password = CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', @new_plain_password), 2)
    WHERE user_id = @uid
END;
