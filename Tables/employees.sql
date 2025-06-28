-- Tabela pracowników
CREATE TABLE employees (
    employee_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary DECIMAL(10,2),
    PRIMARY KEY (employee_id),
    UNIQUE (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;