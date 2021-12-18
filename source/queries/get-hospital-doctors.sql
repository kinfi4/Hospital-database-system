SELECT
    building.name,
    department.name,
    doctor.first_name,
    doctor.last_name,
    doctor.experience
FROM building
    JOIN department on building.id = department.building_id
    JOIN doctor on department.id = doctor.department_id
WHERE building.name = 'National Hostital of Chernigiv'
ORDER BY doctor.first_name, doctor.last_name;