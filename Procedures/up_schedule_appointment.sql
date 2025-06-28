DELIMITER //

CREATE PROCEDURE schedule_appointment(
    IN in_patient_id BIGINT UNSIGNED,
    IN in_employee_id BIGINT UNSIGNED,
    IN in_date DATETIME,
    IN in_duration INT,
    IN in_notes TEXT
)
BEGIN
    INSERT INTO appointments (
        patient_id, employee_id, appointment_date, duration_minutes, status, notes
    ) VALUES (
        in_patient_id, in_employee_id, in_date, in_duration, 'scheduled', in_notes
    );
END;
//

DELIMITER ;
