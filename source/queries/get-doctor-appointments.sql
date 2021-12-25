-----------------------------------------------
--- Get appointment details for specific doctor
--- named Mariele Catie
-----------------------------------------------

SELECT
    doctor.first_name AS doctor_name,
    p.first_name AS patient_name,
    da.time AS appointment_time,
    da.reason,
    da.duration_minutes
FROM doctor
    JOIN doctor_appointment da on doctor.id = da.doctor_id
    JOIN patient p on da.patient_id = p.id
WHERE doctor.first_name = 'Mariele' AND doctor.last_name = 'Catie'
ORDER BY doctor_name, patient_name;
