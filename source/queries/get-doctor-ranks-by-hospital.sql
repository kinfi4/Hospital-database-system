WITH count_department_appointmets (doctor_id, number_of_appointments) AS (
    SELECT
        doc.id,
        count(DISTINCT da.id) AS number_of_procedures
    FROM doctor doc
        JOIN doctor_appointment da ON doc.id = doctor_id
    GROUP BY doc.id
)
SELECT
    h.name AS building_name,
    doc.first_name || ' ' || doc.last_name AS full_name,
    rank() OVER (PARTITION BY h.name ORDER BY cda.number_of_appointments DESC),
    cda.number_of_appointments
FROM doctor doc
    JOIN department d ON department_id = d.id
    JOIN building h ON building_id = h.id
    JOIN count_department_appointmets cda ON cda.doctor_id = doc.id
ORDER BY building_name, number_of_appointments DESC;