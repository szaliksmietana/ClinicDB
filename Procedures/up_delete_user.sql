-- Procedura usuwania użytkownika
CREATE PROCEDURE up_delete_user
    @uid BIGINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Usuń przypisane role
        DELETE FROM tbl_user_roles WHERE user_id = @uid

        -- Usuń dane typu (pracownik / pacjent)
        DELETE FROM tbl_employees WHERE user_id = @uid
        DELETE FROM tbl_patients WHERE user_id = @uid

        -- Pobierz ID kontaktu i adresu przed usunięciem użytkownika
        DECLARE @contact_id BIGINT, @address_id BIGINT
        SELECT @contact_id = contact_id, @address_id = address_id 
        FROM tbl_users WHERE user_id = @uid

        -- Usuń użytkownika z tabeli głównej
        DELETE FROM tbl_users WHERE user_id = @uid

        -- Usuń dane kontaktowe i adresowe (jeśli istnieją)
        IF @contact_id IS NOT NULL
            DELETE FROM tbl_contacts WHERE contact_id = @contact_id
        
        IF @address_id IS NOT NULL
            DELETE FROM tbl_addresses WHERE address_id = @address_id

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END;
