SELECT
    doc.first_name,
    count(*) AS number_of_appointments
FROM doctor doc
    JOIN doctor_specialization ds ON specialization_id = ds.id
    JOIN doctor_appointment da ON doc.id = doctor_id
WHERE ds.name = 'Хирург'
GROUP BY doc.first_name;
