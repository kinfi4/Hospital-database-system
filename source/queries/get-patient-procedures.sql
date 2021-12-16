SELECT
    patient.first_name || ' ' || patient.last_name AS full_patient_name,
    time AS procedure_time,
    duration_minutes,
    model AS equipment_model,
    d.name AS department_name
FROM patient
    JOIN medical_procedure mp ON patient.id = mp.patient_id
    JOIN equipment equip ON mp.equipment_id = equip.id
    JOIN department d ON equip.department_id = d.id
WHERE current_time < mp.time::TIME
ORDER BY time DESC;