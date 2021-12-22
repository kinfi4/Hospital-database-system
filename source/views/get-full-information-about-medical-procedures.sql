CREATE OR REPLACE VIEW get_full_information_about_medical_procedures AS
    SELECT
        p.first_name || ' ' || p.last_name AS patient_full_name,
        e.model AS model,
        time,
        duration_minutes
    FROM medical_procedure
        JOIN patient p ON patient_id = p.id
        JOIN equipment e ON equipment_id = e.id
    WHERE time AT TIME ZONE 'UTC' > current_timestamp;


SELECT * FROM get_full_information_about_medical_procedures;