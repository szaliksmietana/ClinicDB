-- Tabela bazowa użytkowników
CREATE TABLE tbl_users (
    user_id BIGINT IDENTITY(1,1) NOT NULL,
    login NVARCHAR(50) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    pesel NVARCHAR(11),
    birth_date DATE,
    gender NCHAR(1),
    is_forgotten BIT DEFAULT 0,
    address_id BIGINT,
    contact_id BIGINT,
    access_level TINYINT NOT NULL DEFAULT 0,
    CONSTRAINT PK_users PRIMARY KEY (user_id),
    CONSTRAINT FK_users_addresses FOREIGN KEY (address_id) REFERENCES tbl_addresses(address_id),
    CONSTRAINT FK_users_contacts FOREIGN KEY (contact_id) REFERENCES tbl_contacts(contact_id)
);