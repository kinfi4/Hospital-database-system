CREATE OR REPLACE FUNCTION check_appointment_time_func()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$check_app_time$
    DECLARE error_message VARCHAR(255);
    DECLARE day_of_week INT;

    BEGIN
        SELECT EXTRACT(ISODOW FROM New.time) INTO day_of_week;

        IF day_of_week = 6 OR day_of_week = 7  -- checking weekends
        THEN
            SELECT raise_error(error_message);
        END IF;

        

        RETURN New;
    END;
$check_app_time$;

CREATE TRIGGER check_appointment_time_trigger BEFORE INSERT OR UPDATE ON doctor_appointment
    FOR EACH ROW EXECUTE PROCEDURE check_appointment_time_func();
