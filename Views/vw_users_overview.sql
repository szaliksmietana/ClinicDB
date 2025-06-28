CREATE VIEW v_users_overview AS
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
    fu.random_data IS NOT NULL AS anonymized
FROM users u
LEFT JOIN employees e ON u.user_id = e.user_id
LEFT JOIN patients p ON u.user_id = p.user_id
LEFT JOIN forgottenusers fu ON u.user_id = fu.user_id;
