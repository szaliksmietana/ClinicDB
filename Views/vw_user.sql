-- Widok użytkownika aktualnie zalogowanego (dla aplikacji webowych)
CREATE VIEW userview AS
SELECT user_id, login, first_name, last_name, birth_date, gender, address_id, contact_id
FROM users
WHERE login = CURRENT_USER();