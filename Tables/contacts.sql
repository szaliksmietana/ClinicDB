-- Tabela danych kontaktowych
CREATE TABLE tbl_contacts (
    contact_id BIGINT IDENTITY(1,1) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    phone_number NCHAR(9),
    CONSTRAINT PK_contacts PRIMARY KEY (contact_id)
);