
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

-- Tabela danych kontaktowych
CREATE TABLE tbl_contacts (
    contact_id BIGINT IDENTITY(1,1) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    phone_number NCHAR(9),
    CONSTRAINT PK_contacts PRIMARY KEY (contact_id)
);

-- Tabela ról
CREATE TABLE tbl_roles (
    role_id BIGINT IDENTITY(1,1) NOT NULL,
    role_name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_roles PRIMARY KEY (role_id)
);

-- Tabela uprawnień
CREATE TABLE tbl_permissions (
    permission_id BIGINT IDENTITY(1,1) NOT NULL,
    permission_name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_permissions PRIMARY KEY (permission_id)
);

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

-- Tabela pacjentów
CREATE TABLE tbl_patients (
    patient_id BIGINT IDENTITY(1,1) NOT NULL,
    user_id BIGINT NOT NULL,
    insurance_number NVARCHAR(50),
    CONSTRAINT PK_patients PRIMARY KEY (patient_id),
    CONSTRAINT UQ_patients_user_id UNIQUE (user_id),
    CONSTRAINT FK_patients_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);

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

-- Tabela do zapomnianych użytkowników
CREATE TABLE tbl_forgottenusers (
    user_id BIGINT NOT NULL,
    is_forgotten BIT DEFAULT 1,
    random_data NVARCHAR(MAX),
    CONSTRAINT PK_forgottenusers PRIMARY KEY (user_id),
    CONSTRAINT FK_forgottenusers_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);

CREATE TABLE tbl_user_roles (
    user_role_id INT IDENTITY(1,1) NOT NULL,
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    CONSTRAINT PK_user_roles PRIMARY KEY (user_role_id),
    CONSTRAINT UQ_user_roles UNIQUE (user_id, role_id),
    CONSTRAINT FK_user_roles_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id),
    CONSTRAINT FK_user_roles_roles FOREIGN KEY (role_id) REFERENCES tbl_roles(role_id)
);

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

CREATE TABLE tbl_appointments (
    appointment_id BIGINT IDENTITY(1,1) NOT NULL,
    patient_id BIGINT NOT NULL,
    employee_id BIGINT NOT NULL,
    appointment_date DATETIME2 NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 30,
    status NVARCHAR(20) NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'completed', 'cancelled')),
    notes NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT PK_appointments PRIMARY KEY (appointment_id),
    CONSTRAINT FK_appointments_patients FOREIGN KEY (patient_id) REFERENCES tbl_patients(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_appointments_employees FOREIGN KEY (employee_id) REFERENCES tbl_employees(user_id) ON DELETE CASCADE
);
