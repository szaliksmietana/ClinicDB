CREATE TRIGGER trg_delete_user_cleanup
ON tbl_users
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM user_roles
    WHERE user_id IN (SELECT user_id FROM deleted);

    DELETE FROM contacts
    WHERE contact_id IN (SELECT contact_id FROM deleted);

    DELETE FROM addresses
    WHERE address_id IN (SELECT address_id FROM deleted);
END;
