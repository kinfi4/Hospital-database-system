CREATE OR REPLACE FUNCTION check_medical_procedure_available_func()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS
$check_medical_proc_func$
    BEGIN
        IF exists(
                SELECT 1
                FROM medical_procedure
                WHERE extract(HOUR FROM New.time)
        )
        THEN

        END IF;

        RETURN New;
    END;
$check_medical_proc_func$;

CREATE TRIGGER check_medical_procedure_available BEFORE UPDATE OR INSERT ON medical_procedure
    FOR EACH ROW EXECUTE PROCEDURE check_medical_procedure_available_func();