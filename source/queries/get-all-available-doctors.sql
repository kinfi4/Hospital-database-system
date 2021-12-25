-----------------------------------------------
--- Get all available doctors for 2022-01-25 10:27:49.203000
-----------------------------------------------

SELECT
    doctor.first_name || ' ' || doctor.last_name AS full_name,
    doctor_timetable,
    ds.name
FROM get_all_available_doctors_at_specific_time('2022-01-25 10:27:49.203000')
    JOIN doctor ON doctor.id = doctor_id
    JOIN department d ON department_id = d.id
    JOIN building b ON building_id = b.id
    JOIN doctor_specialization ds ON specialization_id = ds.id
WHERE b.name = 'National Hostital of Chernigiv';
