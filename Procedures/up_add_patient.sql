DELIMITER //

CREATE PROCEDURE add_patient (
    IN p_login VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_pesel VARCHAR(11),
    IN p_birth_date DATE,
    IN p_gender CHAR(1),
    IN p_city VARCHAR(100),
    IN p_postal_code VARCHAR(10),
    IN p_street VARCHAR(255),
    IN p_house_number VARCHAR(10),
    IN p_apartment_number VARCHAR(10),
    IN p_email VARCHAR(255),
    IN p_phone CHAR(9),
    IN p_insurance_number VARCHAR(50)
)
BEGIN
    DECLARE new_address_id INT;
    DECLARE new_contact_id INT;
    DECLARE new_user_id BIGINT;

    INSERT INTO addresses (city, postal_code, street, house_number, apartment_number)
    VALUES (p_city, p_postal_code, p_street, p_house_number, p_apartment_number)
    RETURNING address_id INTO new_address_id;

    INSERT INTO contacts (email, phone_number)
    VALUES (p_email, p_phone)
    RETURNING contact_id INTO new_contact_id;

    INSERT INTO users (login, password, first_name, last_name, pesel, birth_date, gender, is_forgotten, address_id, contact_id)
    VALUES (p_login, p_password, p_first_name, p_last_name, p_pesel, p_birth_date, p_gender, 0, new_address_id, new_contact_id)
    RETURNING user_id INTO new_user_id;

    INSERT INTO patients (user_id, insurance_number)
    VALUES (new_user_id, p_insurance_number);
END;
//

DELIMITER ;