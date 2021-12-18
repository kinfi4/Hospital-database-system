WITH count_departments_procedures (department_id, number_of_procedures) AS (
    SELECT
        department.id,
        count(DISTINCT mp.id) AS number_of_procedures
    FROM department
        LEFT JOIN equipment e ON department.id = department_id
        LEFT JOIN medical_procedure mp ON e.id = equipment_id
    GROUP BY department.id
), count_department_appointmets (department_id, number_of_appointmets) AS (
    SELECT
        department.id,
        count(DISTINCT da.id) AS number_of_procedures
    FROM department
        JOIN doctor d ON department.id = department_id
        JOIN doctor_appointment da ON d.id = doctor_id
    GROUP BY department.id
)
SELECT
    h.name,
    department.name,
    number_of_procedures - number_of_appointmets AS difference_between_procedures_and_appointments
FROM department
    JOIN count_departments_procedures ON count_departments_procedures.department_id = department.id
    JOIN count_department_appointmets ON count_department_appointmets.department_id = department.id
    JOIN building h ON building_id = h.id
ORDER BY difference_between_procedures_and_appointments;
