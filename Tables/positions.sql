CREATE TABLE tbl_positions (
    position_id BIGINT IDENTITY PRIMARY KEY,
    position_name NVARCHAR(100) UNIQUE NOT NULL
);
