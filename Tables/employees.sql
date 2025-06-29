-- Tabela pracowników
CREATE TABLE tbl_employees (
    employee_id BIGINT IDENTITY(1,1) NOT NULL,
    user_id BIGINT NOT NULL,
    job_title NVARCHAR(100) NOT NULL,
    hire_date DATE,
    salary DECIMAL(10,2),
    CONSTRAINT PK_employees PRIMARY KEY (employee_id),
    CONSTRAINT UQ_employees_user_id UNIQUE (user_id),
    CONSTRAINT FK_employees_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);