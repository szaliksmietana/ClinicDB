-- Szybkie wyszukiwanie użytkownika po loginie
CREATE INDEX idx_users_login ON users(login);

-- Szybkie wyszukiwanie kontaktu po emailu
CREATE INDEX idx_contacts_email ON contacts(email);

-- Indeks na roli (dla wyszukiwania użytkowników o danej roli)
CREATE INDEX idx_user_roles_role_id ON user_roles(role_id);

-- Wyszukiwanie pacjenta po PESELu
CREATE INDEX idx_users_pesel ON users(pesel);