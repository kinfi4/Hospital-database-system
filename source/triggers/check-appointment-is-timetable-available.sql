CREATE OR REPLACE FUNCTION check_appointment_time_func()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$check_app_time$
    DECLARE error_message VARCHAR(255);
    DECLARE day_of_week INT;
    DECLARE timetable VARCHAR(255);

    BEGIN
        SELECT extract(ISODOW FROM New.time) INTO day_of_week;
        SELECT get_doctor_timetable(New.doctor_id, day_of_week) INTO timetable;

        SELECT concat(
                'Patient: ',
                New.patient_id::VARCHAR, ' cant have an appointment with doctor: ',
                New.doctor_id::VARCHAR, ' at ',
                New.time::VARCHAR, ' because doctor is not working at that time.'
            ) INTO error_message;


        IF New.is_closed = True -- that means we are trying to close the appointment
        THEN
           RETURN New;
        END IF;

        IF day_of_week = 6 OR day_of_week = 7  -- checking weekends
        THEN
            SELECT raise_error(error_message);
        END IF;

        -- 16:00-19:15
        IF (extract(HOUR FROM New.time) > substr(timetable, 1, 2)::INT  -- 16
                    OR (extract(HOUR FROM New.time) = substr(timetable, 1, 2)::INT AND extract(MINUTE FROM New.time) >= substr(timetable, 4, 2)::INT)  -- 00
               AND (extract(HOUR FROM New.time) < substr(timetable, 7, 2)::INT  -- 19
                    OR (extract(HOUR FROM New.time) = substr(timetable, 7, 2)::INT AND extract(MINUTE FROM New.time) <= substr(timetable, 10, 2)::INT)))  -- 15
        THEN
            RETURN New;
        END IF;

        SELECT raise_error(error_message);

    END
$check_app_time$;

CREATE TRIGGER check_appointment_time_trigger BEFORE INSERT OR UPDATE ON doctor_appointment
    FOR EACH ROW EXECUTE PROCEDURE check_appointment_time_func();
