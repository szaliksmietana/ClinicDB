-- Procedura: delete_user
-- Usuwa użytkownika wraz z powiązaniami: role, dane kontaktowe, adres, typ (employee/patient).

DELIMITER //

CREATE PROCEDURE delete_user(IN uid BIGINT UNSIGNED)
BEGIN
    -- Usuń przypisane role
    DELETE FROM user_roles WHERE user_id = uid;

    -- Usuń dane typu (pracownik / pacjent)
    DELETE FROM employees WHERE user_id = uid;
    DELETE FROM patients WHERE user_id = uid;

    -- Usuń dane kontaktowe i adresowe (jeśli istnieją)
    DELETE FROM contacts WHERE contact_id = (
        SELECT contact_id FROM users WHERE user_id = uid
    );
    DELETE FROM addresses WHERE address_id = (
        SELECT address_id FROM users WHERE user_id = uid
    );

    -- Usuń użytkownika z tabeli głównej
    DELETE FROM users WHERE user_id = uid;
END;
//

DELIMITER ;