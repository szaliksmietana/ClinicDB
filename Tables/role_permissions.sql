-- Tabela uprawnień ról
CREATE TABLE tbl_role_permissions (
    role_permission_id INT IDENTITY(1,1) NOT NULL,
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    CONSTRAINT PK_role_permissions PRIMARY KEY (role_permission_id),
    CONSTRAINT UQ_role_permissions UNIQUE (role_id, permission_id),
    CONSTRAINT FK_role_permissions_roles FOREIGN KEY (role_id) REFERENCES tbl_roles(role_id),
    CONSTRAINT FK_role_permissions_permissions FOREIGN KEY (permission_id) REFERENCES tbl_permissions(permission_id)
);