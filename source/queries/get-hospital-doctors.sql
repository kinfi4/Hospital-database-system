SELECT
    hospital.name,
    department.name,
    doctor.first_name,
    doctor.last_name,
    doctor.experience
FROM hospital
    JOIN department on hospital.id = department.hospital_id
    JOIN doctor on department.id = doctor.department_id
WHERE hospital.name = 'National Hostital of Chernigiv'
ORDER BY doctor.first_name, doctor.last_name;