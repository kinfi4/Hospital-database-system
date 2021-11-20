CREATE OR REPLACE FUNCTION raise_error(text VARCHAR(255))
    RETURNS VOID
    LANGUAGE plpgsql
    AS
$raise_err$
BEGIN
    RAISE EXCEPTION '%s', $1;
END;
$raise_err$;