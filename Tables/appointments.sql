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