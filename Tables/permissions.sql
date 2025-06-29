-- Tabela uprawnień
CREATE TABLE tbl_permissions (
    permission_id BIGINT IDENTITY(1,1) NOT NULL,
    permission_name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_permissions PRIMARY KEY (permission_id)
);