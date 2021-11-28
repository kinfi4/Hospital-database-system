SELECT
    equipment.model AS Model,
    d.name AS department_name,
    p.first_name AS patinet_first_name,
    p.last_name AS patient_last_name,
    to_char(time, 'YYYY-MM-DD HH24:MI') AS starting_time,
    duration_minutes
FROM equipment
    JOIN medical_procedure mp on equipment.id = mp.equipment_id
    JOIN patient p on mp.patient_id = p.id
    JOIN department d on equipment.department_id = d.id
WHERE equipment.id = 1
ORDER BY equipment.model;
