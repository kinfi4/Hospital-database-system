CREATE OR REPLACE FUNCTION check_medical_procedure_available_func()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS
$check_medical_proc_func$
    DECLARE error_message VARCHAR(355);

    BEGIN
        SELECT concat(
                'Patient: ',
                New.patient_id::VARCHAR, ' cant have an procedure with equipment: ',
                New.equipment_id::VARCHAR, ' at ',
                New.time::VARCHAR, ' because it is busy at that moment.'
            ) INTO error_message;

        IF (
            SELECT count(*) FROM medical_procedure
            WHERE New.time >= time
                AND New.time <= (time + (duration_minutes || ' minutes')::INTERVAL)
        ) > 0
        THEN
            SELECT raise_error(error_message);
        END IF;

        RETURN New;
    END
$check_medical_proc_func$;

CREATE TRIGGER check_medical_procedure_available BEFORE UPDATE OR INSERT ON medical_procedure
    FOR EACH ROW EXECUTE PROCEDURE check_medical_procedure_available_func();