-----------------------------------------------
--- Get all doctor appointments, ordered by
--- number of appointments of the doctor using WINDOWS FUNCTIONSa
-----------------------------------------------

SELECT
    doc.id,
    doc.first_name || ' ' || doc.last_name AS full_name,
    da.time AS appointment_time,
    da.cabinet_number,
    count(*) OVER (PARTITION BY doc.id) AS number_of_appointments
FROM doctor doc
    JOIN doctor_specialization ds ON doc.specialization_id = ds.id
    JOIN doctor_appointment da ON doc.id = da.doctor_id
ORDER BY number_of_appointments DESC, full_name;