-----------------------------------------------
--- Get specific patient appointments
-----------------------------------------------

SELECT
    doctor.first_name AS doctor_name,
    p.first_name AS patient_name,
    da.time AS appointment_time
FROM doctor
    JOIN doctor_appointment da on doctor.id = da.doctor_id
    JOIN patient p on da.patient_id = p.id
WHERE p.first_name = 'Christal' AND p.last_name = 'Graig'
ORDER BY doctor_name, patient_name;
