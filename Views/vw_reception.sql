-- Widok z użytkownikami dla recepcji
CREATE VIEW receptionview AS
SELECT user_id, login, first_name, last_name, birth_date, gender, address_id, contact_id
FROM users;