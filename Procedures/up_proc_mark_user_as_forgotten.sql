--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- proc_mark_user_as_forgotten (@user_id BIGINT)
--- CREATED BY: Oskar Sobczak
--------------------------------------------------------------------------------------
-- Procedura oznacza użytkownika jako zapomnianego w systemie. Sprawdza, czy użytkownik o podanym
-- identyfikatorze istnieje, a następnie oznacza go jako zapomnianego, jeżeli wcześniej tego nie zrobił.
-- Jeżeli użytkownik już został oznaczony jako zapomniany, procedura zwraca odpowiedni komunikat.
--
-- parametry wejściowe:
-- @user_id - identyfikator użytkownika, który ma zostać oznaczony jako zapomniany
--
-- parametry wyjściowe/zwracane wartości:
-- Brak wartości wyjściowych. Procedura wyświetla komunikaty o błędach lub potwierdzenia wykonania operacji.
-- Komunikaty:
-- - 'Użytkownik o podanym ID nie istnieje.'
-- - 'Użytkownik już został oznaczony jako zapomniany.'
-- - 'Użytkownik został oznaczony jako zapomniany.'
--
--
-- /*
-- Przykład użycia
EXEC proc_mark_user_as_forgotten 123
--
-- Wynik działania
-- Zwrócono komunikat: 'Użytkownik został oznaczony jako zapomniany.'
......................................................................................

CREATE OR ALTER PROCEDURE proc_mark_user_as_forgotten
    @user_id BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Sprawdzenie, czy użytkownik istnieje
    IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = @user_id)
    BEGIN
        RAISERROR('Użytkownik o podanym ID nie istnieje.', 16, 1);
        RETURN;
    END

    -- Sprawdzenie, czy użytkownik nie został już zapomniany
    IF EXISTS (SELECT 1 FROM users WHERE user_id = @user_id AND is_forgotten = 1)
    BEGIN
        PRINT 'Użytkownik już został oznaczony jako zapomniany.';
        RETURN;
    END

    -- Oznaczenie użytkownika jako zapomnianego – trigger zadba o anonimizację
    UPDATE users
    SET is_forgotten = 1
    WHERE user_id = @user_id;

    PRINT 'Użytkownik został oznaczony jako zapomniany.';
END;
