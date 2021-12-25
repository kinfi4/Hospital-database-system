-----------------------------------------------
--- Get doctor with id = 1 timetable
--- for tuesday
-----------------------------------------------

SELECT
    *
FROM get_doctor_timetable((SELECT id FROM doctor WHERE first_name = 'Ada' AND last_name = 'Rossner'),
                      (SELECT extract(ISODOW FROM CURRENT_DATE))::INT);

