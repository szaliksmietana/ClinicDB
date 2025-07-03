CREATE OR ALTER TRIGGER trg_check_position_validity
ON tbl_employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN tbl_positions p ON i.position_id = p.position_id
        WHERE p.position_id IS NULL
    )
    BEGIN
        RAISERROR('Nieprawidłowa wartość stanowiska (position_id).', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
