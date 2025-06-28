CREATE PROCEDURE check_if_user_forgotten (IN uid BIGINT)
BEGIN
    SELECT is_forgotten, random_data
    FROM forgottenusers
    WHERE user_id = uid;
END;