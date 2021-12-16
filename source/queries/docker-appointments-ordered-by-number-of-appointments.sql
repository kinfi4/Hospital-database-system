WITH ordered_doctors(doc_id, number_of_appointments) AS (
    SELECT doc.id, count(*) FROM doctor doc
        JOIN doctor_appointment d ON doc.id = d.doctor_id
    GROUP BY doc.id
)
SELECT
    doc.id,
    doc.first_name || ' ' || doc.last_name AS full_name,
    ds.name AS specialization_name,
    number_of_appointments
FROM doctor doc
    JOIN doctor_appointment da ON doc.id = da.doctor_id
    JOIN ordered_doctors ON ordered_doctors.doc_id = doc.id
    JOIN doctor_specialization ds ON doc.specialization_id = ds.id
ORDER BY number_of_appointments DESC, full_name;