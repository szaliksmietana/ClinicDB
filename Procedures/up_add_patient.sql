--------------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_add_patient (@p_login NVARCHAR(50), @p_password NVARCHAR(255), @p_first_name NVARCHAR(100),
--- @p_last_name NVARCHAR(100), @p_pesel NVARCHAR(11), @p_birth_date DATE, @p_gender NCHAR(1),
--- @p_city NVARCHAR(100), @p_postal_code NVARCHAR(10), @p_street NVARCHAR(255),
--- @p_house_number NVARCHAR(10), @p_apartment_number NVARCHAR(10), @p_email NVARCHAR(255),
--- @p_phone NCHAR(9), @p_insurance_number NVARCHAR(50))
--- CREATED BY: Filip Szymański
--------------------------------------------------------------------------------------
-- Procedura służy do dodawania nowego pacjenta do systemu. Wykonuje ona następujące kroki:
-- 1. Dodaje adres pacjenta do tabeli tbl_addresses.
-- 2. Dodaje dane kontaktowe pacjenta do tabeli tbl_contacts.
-- 3. Dodaje dane użytkownika (login, hasło, dane osobowe) do tabeli tbl_users.
-- 4. Dodaje dane pacjenta (numer ubezpieczenia) do tabeli tbl_patients.
--
-- parametry wejściowe:
-- @p_login - login użytkownika
-- @p_password - hasło użytkownika
-- @p_first_name - imię pacjenta
-- @p_last_name - nazwisko pacjenta
-- @p_pesel - numer PESEL pacjenta
-- @p_birth_date - data urodzenia pacjenta
-- @p_gender - płeć pacjenta (M/K)
-- @p_city - miasto zamieszkania pacjenta
-- @p_postal_code - kod pocztowy pacjenta
-- @p_street - ulica zamieszkania pacjenta
-- @p_house_number - numer domu pacjenta
-- @p_apartment_number - numer mieszkania pacjenta
-- @p_email - adres e-mail pacjenta
-- @p_phone - numer telefonu pacjenta
-- @p_insurance_number - numer ubezpieczenia pacjenta
--
-- parametry wyjściowe/zwracane wartości:
-- Brak wartości wyjściowych, procedura nie zwraca żadnych danych, ale wykonuje operacje na bazie danych.
--
--
-- /*
-- Przykład użycia
DECLARE @new_patient_id BIGINT
EXEC up_add_patient 'login123', 'hasło123', 'Jan', 'Kowalski', '12345678901', '1980-01-01', 'M', 'Warszawa', '00-001', 'Krakowska', '10', '5', 'jan.kowalski@email.com', '123456789', '123456'
--
-- Wynik działania
-- Zapisano nowego pacjenta w systemie.
......................................................................................

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
