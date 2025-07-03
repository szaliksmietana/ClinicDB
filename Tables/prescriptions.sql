CREATE TABLE tbl_prescriptions (
    prescription_id BIGINT IDENTITY PRIMARY KEY,
    appointment_id BIGINT NOT NULL,
    medicine_name NVARCHAR(255) NOT NULL,
    dosage NVARCHAR(100),
    instructions NVARCHAR(500),
    issued_at DATETIME2 DEFAULT GETDATE(),

    FOREIGN KEY (appointment_id) REFERENCES tbl_appointments(appointment_id) ON DELETE CASCADE
);
