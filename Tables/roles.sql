-- Tabela ról
CREATE TABLE tbl_roles (
    role_id BIGINT IDENTITY(1,1) NOT NULL,
    role_name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_roles PRIMARY KEY (role_id)
);