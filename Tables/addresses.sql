-- Tabela adresów
CREATE TABLE tbl_addresses (
    address_id BIGINT IDENTITY(1,1) NOT NULL,
    city NVARCHAR(100) NOT NULL,
    postal_code NVARCHAR(10) NOT NULL,
    street NVARCHAR(255) NOT NULL,
    house_number NVARCHAR(10) NOT NULL,
    apartment_number NVARCHAR(10),
    CONSTRAINT PK_addresses PRIMARY KEY (address_id)
);