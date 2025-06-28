-- Procedura: reset_user_password
-- Ustawia nowe hasło SHA2(256) dla użytkownika o podanym ID.

DELIMITER //

CREATE PROCEDURE reset_user_password(
    IN uid BIGINT UNSIGNED,
    IN new_plain_password VARCHAR(100)
)
BEGIN
    UPDATE users
    SET password = SHA2(new_plain_password, 256)
    WHERE user_id = uid;
END;
//

DELIMITER ;