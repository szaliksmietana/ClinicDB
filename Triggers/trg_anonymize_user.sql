-- Trigger do anonimizacji danych po oznaczeniu użytkownika jako zapomniany
DELIMITER ;;
CREATE TRIGGER trg_anonymize_user
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.is_forgotten = TRUE AND OLD.is_forgotten = FALSE THEN

        -- Dodaj wpis do tabeli zapomnianych użytkowników
        INSERT INTO forgottenusers (user_id, is_forgotten, random_data)
        VALUES (OLD.user_id, TRUE, UUID());

        -- Anonimizacja danych użytkownika
        SET NEW.login = CONCAT('deleted', OLD.user_id);
        SET NEW.password = SHA2(RAND(), 256); -- silniejszy hash
        SET NEW.first_name = 'Anon';
        SET NEW.last_name = 'User';
        SET NEW.pesel = NULL;
        SET NEW.birth_date = NULL;
        SET NEW.gender = NULL;
        SET NEW.address_id = NULL;
        SET NEW.contact_id = NULL;
        SET NEW.access_level = 0;

        -- Usuwanie powiązań kontaktów i adresów (jeśli istnieją)
        IF OLD.contact_id IS NOT NULL THEN
            DELETE FROM contacts WHERE contact_id = OLD.contact_id;
        END IF;

        IF OLD.address_id IS NOT NULL THEN
            DELETE FROM addresses WHERE address_id = OLD.address_id;
        END IF;

        -- Usuwanie ról użytkownika
        DELETE FROM user_roles WHERE user_id = OLD.user_id;
    END IF;
END ;;

DELIMITER ;