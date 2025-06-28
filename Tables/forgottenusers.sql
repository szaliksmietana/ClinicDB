-- Tabela do zapomnianych użytkowników
CREATE TABLE forgottenusers (
    user_id BIGINT UNSIGNED NOT NULL,
    is_forgotten TINYINT(1) DEFAULT 1,
    random_data TEXT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;