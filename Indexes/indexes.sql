-- Szybkie wyszukiwanie użytkownika po loginie
CREATE INDEX idx_users_login ON tbl_users(login);

-- Szybkie wyszukiwanie kontaktu po emailu
CREATE INDEX idx_contacts_email ON tbl_contacts(email);

-- Indeks na roli (dla wyszukiwania użytkowników o danej roli)
CREATE INDEX idx_user_roles_role_id ON tbl_user_roles(role_id);

-- Wyszukiwanie pacjenta po PESELu
CREATE INDEX idx_users_pesel ON tbl_users(pesel);

-- Unikalność adresu email
CREATE UNIQUE INDEX idx_contacts_email_unique ON tbl_contacts(email);
