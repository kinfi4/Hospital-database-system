CREATE OR REPLACE FUNCTION get_doctor_timetable(doc_id INT, day_of_week INT)
    RETURNS VARCHAR(255)
    LANGUAGE plpgsql
    AS
$get_docktor_tt$
    DECLARE doctor_timetable VARCHAR;
    BEGIN
        SELECT
            CASE
                WHEN day_of_week = 1 THEN monday_timetable
                WHEN day_of_week = 2 THEN thursday_timetable
                WHEN day_of_week = 3 THEN wednesday_timetable
                WHEN day_of_week = 4 THEN thursday_timetable
                WHEN day_of_week = 5 THEN friday_timetable
                ELSE 'No timetable'
            END
        FROM doctor_timetable
        WHERE id IN (SELECT timetable_id FROM doctor WHERE id = doc_id) INTO doctor_timetable;

        RETURN doctor_timetable;
    END;
$get_docktor_tt$;