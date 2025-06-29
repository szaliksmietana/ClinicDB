-- Procedura sprawdzania czy użytkownik jest zapomniany
CREATE PROCEDURE up_check_if_user_forgotten
    @uid BIGINT
AS
BEGIN
    SELECT is_forgotten, random_data
    FROM tbl_forgottenusers
    WHERE user_id = @uid
END;
