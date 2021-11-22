CREATE FUNCTION get_doctor_timetable(doc_id INT, day_of_week INT)
    RETURNS VARCHAR(255)
    LANGUAGE plpgsql
    AS
$get_docktor_tt$
    BEGIN
        SELECT
            CASE
                WHEN day_of_week = 1 THEN monday_timetable
                WHEN day_of_week = 2 THEN thursday_timetable
                WHEN day_of_week = 3 THEN wednesday_timetable
                WHEN day_of_week = 4 THEN thursday_timetable
                WHEN day_of_week = 5 THEN friday_timetable
                ELSE raise_error('You passed invalid dow, working day of the week must be between 1 and 5')
            END
        FROM doctor_timetable
        WHERE doctor_timetable.doctor_id = doc_id;
    END;
$get_docktor_tt$;