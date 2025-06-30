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
