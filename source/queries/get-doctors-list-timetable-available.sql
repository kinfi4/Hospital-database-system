-----------------------------------------------
--- Get all available doctors for time
--- 2022-04-05T08:15:43.258Z
-----------------------------------------------

SELECT
    doctor.first_name || ' ' || doctor.last_name AS full_name,
    doctor_timetable,
    d.name,
    address
FROM get_all_available_doctors_at_specific_time('2022-04-05T08:15:43.258Z'::TIMESTAMP)
    JOIN doctor ON doctor.id = doctor_id
    JOIN department d ON department_id = d.id
    JOIN building b ON building_id = b.id
WHERE b.name = 'National Hostital of Chernigiv';

