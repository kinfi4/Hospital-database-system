-----------------------------------------------
--- Get summaric experience for each building
--- for each department
-----------------------------------------------

SELECT
    b.name AS building_name,
    d.name AS department_name,
    sum(doctor.experience) AS summaric_experience
FROM doctor
    JOIN department d ON department_id = d.id
    JOIN building b ON building_id = b.id
GROUP BY d.name, b.name
ORDER BY summaric_experience DESC;