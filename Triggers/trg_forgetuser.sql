-- Trigger do anonimizacji danych po oznaczeniu użytkownika jako zapomniany
DELIMITER ;;
CREATE TRIGGER anonymize_user AFTER UPDATE ON users FOR EACH ROW
BEGIN
    IF NEW.is_forgotten = TRUE AND OLD.is_forgotten = FALSE THEN
        INSERT INTO forgottenusers (user_id, is_forgotten, random_data)
        VALUES (NEW.user_id, TRUE, MD5(RAND()));

        UPDATE users
        SET
            login = CONCAT('deleted', NEW.user_id),
            password = MD5(RAND()),
            first_name = 'Anon',
            last_name = 'User',
            pesel = NULL,
            birth_date = NULL,
            gender = NULL,
            address_id = NULL,
            contact_id = NULL,
            access_level = 0
        WHERE user_id = NEW.user_id;
    END IF;
END ;;
DELIMITER ;
