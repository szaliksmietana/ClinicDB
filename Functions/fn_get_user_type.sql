-- Funkcja zwracająca typ użytkownika
CREATE FUNCTION uf_get_user_type(@uid BIGINT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @result NVARCHAR(20)
    
    IF EXISTS (SELECT 1 FROM tbl_employees WHERE user_id = @uid)
        SET @result = 'employee'
    ELSE IF EXISTS (SELECT 1 FROM tbl_patients WHERE user_id = @uid)
        SET @result = 'patient'
    ELSE
        SET @result = 'unknown'
    
    RETURN @result
END;
