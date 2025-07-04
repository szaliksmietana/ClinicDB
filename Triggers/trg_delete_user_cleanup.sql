--------------------------------------------------------------------------------------
--- TRIGGER DEFINITION
--- trg_delete_user_cleanup ON tbl_users AFTER DELETE
--- CREATED BY: Kacper Wardziński
--------------------------------------------------------------------------------------
-- Wyzwalacz uruchamiany po usunięciu użytkownika z tabeli tbl_users. Odpowiada za usunięcie
-- danych związanych z użytkownikiem z innych tabel, takich jak:
-- 1. Usunięcie powiązanych ról użytkownika z tabeli user_roles.
-- 2. Usunięcie powiązanych danych kontaktowych użytkownika z tabeli contacts.
-- 3. Usunięcie powiązanych danych adresowych użytkownika z tabeli addresses.
--
-- parametry wejściowe:
-- Brak parametrów wejściowych. Wyzwalacz jest uruchamiany automatycznie po usunięciu rekordu
-- z tabeli tbl_users.
--
-- parametry wyjściowe/zwracane wartości:
-- Brak. Wyzwalacz nie zwraca danych, ale wykonuje operacje usuwania danych w bazie.
--
--
-- /*
-- Przykład użycia
-- Wyzwalacz uruchomi się automatycznie po usunięciu rekordu z tabeli tbl_users, np.:
-- DELETE FROM tbl_users WHERE user_id = 123
--
-- Wynik działania
-- Usunięto powiązane dane użytkownika z tabel user_roles, contacts oraz addresses.
......................................................................................

CREATE TRIGGER trg_delete_user_cleanup
ON tbl_users
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM user_roles
    WHERE user_id IN (SELECT user_id FROM deleted);

    DELETE FROM contacts
    WHERE contact_id IN (SELECT contact_id FROM deleted);

    DELETE FROM addresses
    WHERE address_id IN (SELECT address_id FROM deleted);
END;
