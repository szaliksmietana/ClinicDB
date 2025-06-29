-- Tabela do zapomnianych użytkowników
CREATE TABLE tbl_forgottenusers (
    user_id BIGINT NOT NULL,
    is_forgotten BIT DEFAULT 1,
    random_data NVARCHAR(MAX),
    CONSTRAINT PK_forgottenusers PRIMARY KEY (user_id),
    CONSTRAINT FK_forgottenusers_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);