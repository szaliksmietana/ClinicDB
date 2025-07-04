--------------------------------------------------------------------------------------
--- TRIGGER DEFINITION
--- trg_anonymize_user ON tbl_users FOR UPDATE
--- CREATED BY: Filip Szymański
--------------------------------------------------------------------------------------
-- Wyzwalacz wykonuje anonimizację danych użytkownika po oznaczeniu go jako zapomnianego.
-- Sprawdza, czy pole is_forgotten zostało zmienione na 1, a jeżeli tak, to przeprowadza proces
-- anonimizacji danych użytkownika, w tym:
-- 1. Dodaje wpis do tabeli tbl_forgottenusers.
-- 2. Anonimizuje dane użytkownika (login, hasło, imię, nazwisko, pesel, data urodzenia).
-- 3. Usuwa powiązania z tabelami kontaktów (tbl_contacts) i adresów (tbl_addresses).
-- 4. Usuwa role użytkownika z tabeli tbl_user_roles.
--
-- parametry wejściowe:
-- Brak parametrów wejściowych. Wyzwalacz jest uruchamiany automatycznie podczas aktualizacji
-- rekordu w tabeli tbl_users, gdy pole is_forgotten zostaje zmienione na 1.
--
-- parametry wyjściowe/zwracane wartości:
-- Brak. Wyzwalacz nie zwraca danych, ale wykonuje operacje modyfikacji danych w bazie.
--
--
-- /*
-- Przykład użycia
-- Wyzwalacz uruchomi się automatycznie po zaktualizowaniu tabeli tbl_users, np.:
-- UPDATE tbl_users SET is_forgotten = 1 WHERE user_id = 123
--
-- Wynik działania
-- Zaktualizowano dane użytkownika, oznaczono go jako zapomnianego i przeprowadzono anonimizację danych.
......................................................................................

CREATE TRIGGER trg_anonymize_user
ON tbl_users
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(is_forgotten)
    BEGIN
        DECLARE @user_id BIGINT, @old_contact_id BIGINT, @old_address_id BIGINT
        
        SELECT @user_id = i.user_id, @old_contact_id = d.contact_id, @old_address_id = d.address_id
        FROM inserted i
        INNER JOIN deleted d ON i.user_id = d.user_id
        WHERE i.is_forgotten = 1 AND d.is_forgotten = 0

        IF @user_id IS NOT NULL
        BEGIN
            -- Dodaj wpis do tabeli zapomnianych użytkowników
            INSERT INTO tbl_forgottenusers (user_id, is_forgotten, random_data)
            VALUES (@user_id, 1, NEWID())

            -- Anonimizacja danych użytkownika
            UPDATE tbl_users
            SET 
                login = 'deleted' + CAST(@user_id AS NVARCHAR(20)),
                password = CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', CONVERT(NVARCHAR(36), NEWID())), 2),
                first_name = 'Anon',
                last_name = 'User',
                pesel = NULL,
                birth_date = NULL,
                gender = NULL,
                address_id = NULL,
                contact_id = NULL,
                access_level = 0
            WHERE user_id = @user_id

            -- Usuwanie powiązań kontaktów i adresów (jeśli istnieją)
            IF @old_contact_id IS NOT NULL
                DELETE FROM tbl_contacts WHERE contact_id = @old_contact_id

            IF @old_address_id IS NOT NULL
                DELETE FROM tbl_addresses WHERE address_id = @old_address_id

            -- Usuwanie ról użytkownika
            DELETE FROM tbl_user_roles WHERE user_id = @user_id
        END
    END
END;
