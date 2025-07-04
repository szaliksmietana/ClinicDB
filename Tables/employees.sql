-- Tabela pracowników z referencją do słownika pozycji
CREATE TABLE tbl_employees (
    employee_id BIGINT IDENTITY(1,1) NOT NULL,
    user_id BIGINT NOT NULL,
    position_id BIGINT NOT NULL,
    hire_date DATE,
    salary DECIMAL(10,2),
    
    CONSTRAINT PK_employees PRIMARY KEY (employee_id),
    CONSTRAINT UQ_employees_user_id UNIQUE (user_id),
    CONSTRAINT FK_employees_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_employees_positions FOREIGN KEY (position_id) REFERENCES tbl_positions(position_id)
);
