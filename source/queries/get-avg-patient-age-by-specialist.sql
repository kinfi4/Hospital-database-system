-----------------------------------------------
--- Get average age of patients by
--- doctors specialization
-----------------------------------------------

SELECT
    ds.name AS specialization_name,
    count(*) AS number_of_appointments,
    round(avg(patient.age), 2) AS average_age
FROM patient
    JOIN doctor_appointment da ON patient.id = patient_id
    JOIN doctor d ON doctor_id = d.id
    JOIN doctor_specialization ds ON specialization_id = ds.id
GROUP BY ds.name