-- Widok przeglądu użytkowników
CREATE VIEW vw_users_overview AS
SELECT 
    u.user_id,
    u.login,
    u.first_name,
    u.last_name,
    CASE 
        WHEN e.user_id IS NOT NULL THEN 'employee'
        WHEN p.user_id IS NOT NULL THEN 'patient'
        ELSE 'unknown'
    END AS user_type,
    u.is_forgotten,
    CASE WHEN fu.random_data IS NOT NULL THEN 1 ELSE 0 END AS anonymized
FROM tbl_users u
LEFT JOIN tbl_employees e ON u.user_id = e.user_id
LEFT JOIN tbl_patients p ON u.user_id = p.user_id
LEFT JOIN tbl_forgottenusers fu ON u.user_id = fu.user_id;
