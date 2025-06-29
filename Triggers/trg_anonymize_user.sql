-- Wyzwalacz do anonimizacji danych po oznaczeniu użytkownika jako zapomniany
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
