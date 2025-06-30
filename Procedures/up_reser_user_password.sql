CREATE PROCEDURE reset_user_password
    @uid BIGINT,
    @new_plain_password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE tbl_users
    SET password = CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', @new_plain_password), 2)
    WHERE user_id = @uid;
END;
