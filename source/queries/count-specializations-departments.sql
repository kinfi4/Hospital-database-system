SELECT
    d.name AS department_name,
    ds.name AS specialization_name,
    count(*) AS number_of_doctors
FROM doctor doc
    JOIN doctor_specialization ds ON doc.specialization_id = ds.id
    JOIN department d ON doc.department_id = d.id
GROUP BY department_name, specialization_name
ORDER BY number_of_doctors DESC;