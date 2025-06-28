DELIMITER //

CREATE TRIGGER prevent_employee_overlap
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;

    SELECT COUNT(*) INTO overlap_count
    FROM appointments
    WHERE
        employee_id = NEW.employee_id
        AND status = 'scheduled'
        AND (
            NEW.appointment_date BETWEEN appointment_date AND DATE_ADD(appointment_date, INTERVAL duration_minutes MINUTE)
            OR DATE_ADD(NEW.appointment_date, INTERVAL NEW.duration_minutes MINUTE) > appointment_date
               AND NEW.appointment_date < DATE_ADD(appointment_date, INTERVAL duration_minutes MINUTE)
        );

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pracownik ma już zaplanowaną wizytę w tym czasie.';
    END IF;
END;
//

DELIMITER ;
