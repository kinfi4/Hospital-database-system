-----------------------------------------------
--- Get doctors timetables for current day
-----------------------------------------------

SELECT
    doc.first_name || ' ' || doc.last_name AS full_name,
    CASE
        WHEN extract(ISODOW FROM current_date) IN (6, 7) THEN 'no timetable, its weekend'
        ELSE get_doctor_timetable(doc.id, extract(ISODOW  FROM current_date)::INT)
    END
FROM doctor doc;