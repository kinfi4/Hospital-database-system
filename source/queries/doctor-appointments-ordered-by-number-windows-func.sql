SELECT
    doc.id,
    doc.first_name || ' ' || doc.last_name AS full_name,
    count(*) OVER (PARTITION BY doc.id) AS number_of_appointments
FROM doctor doc
    JOIN doctor_specialization ds ON doc.specialization_id = ds.id
    JOIN doctor_appointment da ON doc.id = da.doctor_id
ORDER BY number_of_appointments DESC, full_name;