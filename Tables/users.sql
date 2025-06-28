-- Tabela bazowa użytkowników
CREATE TABLE users (
    user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    pesel VARCHAR(11),
    birth_date DATE,
    gender CHAR(1),
    is_forgotten TINYINT(1),
    address_id INT,
    contact_id INT,
    access_level TINYINT NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (contact_id) REFERENCES contacts(contact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;