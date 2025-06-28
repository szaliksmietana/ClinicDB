CREATE TRIGGER trg_delete_user_cleanup
AFTER DELETE ON users
FOR EACH ROW
BEGIN
    DELETE FROM user_roles WHERE user_id = OLD.user_id;
    DELETE FROM contacts WHERE contact_id = OLD.contact_id;
    DELETE FROM addresses WHERE address_id = OLD.address_id;
END;