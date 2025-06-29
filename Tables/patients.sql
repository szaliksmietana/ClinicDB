-- Tabela pacjentów
CREATE TABLE tbl_patients (
    patient_id BIGINT IDENTITY(1,1) NOT NULL,
    user_id BIGINT NOT NULL,
    insurance_number NVARCHAR(50),
    CONSTRAINT PK_patients PRIMARY KEY (patient_id),
    CONSTRAINT UQ_patients_user_id UNIQUE (user_id),
    CONSTRAINT FK_patients_users FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);
