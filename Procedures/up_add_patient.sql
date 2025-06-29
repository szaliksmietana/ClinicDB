-- Procedura dodawania pacjenta
CREATE PROCEDURE up_add_patient
    @p_login NVARCHAR(50),
    @p_password NVARCHAR(255),
    @p_first_name NVARCHAR(100),
    @p_last_name NVARCHAR(100),
    @p_pesel NVARCHAR(11),
    @p_birth_date DATE,
    @p_gender NCHAR(1),
    @p_city NVARCHAR(100),
    @p_postal_code NVARCHAR(10),
    @p_street NVARCHAR(255),
    @p_house_number NVARCHAR(10),
    @p_apartment_number NVARCHAR(10),
    @p_email NVARCHAR(255),
    @p_phone NCHAR(9),
    @p_insurance_number NVARCHAR(50)
AS
BEGIN
    DECLARE @new_address_id BIGINT
    DECLARE @new_contact_id BIGINT
    DECLARE @new_user_id BIGINT

    BEGIN TRY
        BEGIN TRANSACTION

        INSERT INTO tbl_addresses (city, postal_code, street, house_number, apartment_number)
        VALUES (@p_city, @p_postal_code, @p_street, @p_house_number, @p_apartment_number)
        SET @new_address_id = SCOPE_IDENTITY()

        INSERT INTO tbl_contacts (email, phone_number)
        VALUES (@p_email, @p_phone)
        SET @new_contact_id = SCOPE_IDENTITY()

        INSERT INTO tbl_users (login, password, first_name, last_name, pesel, birth_date, gender, is_forgotten, address_id, contact_id, access_level)
        VALUES (@p_login, @p_password, @p_first_name, @p_last_name, @p_pesel, @p_birth_date, @p_gender, 0, @new_address_id, @new_contact_id, 1)
        SET @new_user_id = SCOPE_IDENTITY()

        INSERT INTO tbl_patients (user_id, insurance_number)
        VALUES (@new_user_id, @p_insurance_number)

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END;
