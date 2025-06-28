-- Funkcja: get_user_type
-- Zwraca 'employee', 'patient' lub 'unknown' na podstawie typu użytkownika.

CREATE FUNCTION get_user_type(uid BIGINT UNSIGNED)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF EXISTS (SELECT 1 FROM employees WHERE user_id = uid) THEN
        RETURN 'employee';
    ELSEIF EXISTS (SELECT 1 FROM patients WHERE user_id = uid) THEN
        RETURN 'patient';
    ELSE
        RETURN 'unknown';
    END IF;
END;