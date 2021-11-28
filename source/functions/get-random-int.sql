CREATE OR REPLACE FUNCTION get_random_integer(low INT, high INT)
    RETURNS INT
    LANGUAGE plpgsql
    AS
$$
    BEGIN
        RETURN floor(random() * (high-low + 1) + low);
    END;
$$