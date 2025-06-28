-- Table adresów
CREATE TABLE addresses (
    address_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    street VARCHAR(255) NOT NULL,
    house_number VARCHAR(10) NOT NULL,
    apartment_number VARCHAR(10),
    PRIMARY KEY (address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;