
-- Table adresów
CREATE TABLE addresses (
    address_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    street VARCHAR(255) NOT NULL,
    house_number VARCHAR(10) NOT NULL,
    apartment_number VARCHAR(10),
    PRIMARY KEY (address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela danych kontaktowych
CREATE TABLE contacts (
    contact_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    phone_number CHAR(9),
    PRIMARY KEY (contact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela ról
CREATE TABLE roles (
    role_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela uprawnień
CREATE TABLE permissions (
    permission_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    permission_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela bazowa użytkowników
CREATE TABLE users (
    user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    pesel VARCHAR(11),
    birth_date DATE,
    gender CHAR(1),
    is_forgotten TINYINT(1),
    address_id INT,
    contact_id INT,
    access_level TINYINT NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (contact_id) REFERENCES contacts(contact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela pacjentów
CREATE TABLE patients (
    patient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    insurance_number VARCHAR(50),
    PRIMARY KEY (patient_id),
    UNIQUE (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- Tabela do zapomnianych użytkowników
CREATE TABLE forgottenusers (
    user_id BIGINT UNSIGNED NOT NULL,
    is_forgotten TINYINT(1) DEFAULT 1,
    random_data TEXT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela ról użytkowników
CREATE TABLE user_roles (
    user_role_id INT NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_role_id),
    UNIQUE (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela uprawnień ról
CREATE TABLE role_permissions (
    role_permission_id INT NOT NULL AUTO_INCREMENT,
    role_id BIGINT UNSIGNED NOT NULL,
    permission_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (role_permission_id),
    UNIQUE (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela wizyt
CREATE TABLE appointments (
    appointment_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_id BIGINT UNSIGNED NOT NULL,
    employee_id BIGINT UNSIGNED NOT NULL,
    appointment_date DATETIME NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 30,
    status ENUM('scheduled', 'completed', 'cancelled') NOT NULL DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (appointment_id),
    
    FOREIGN KEY (patient_id) REFERENCES patients(user_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;