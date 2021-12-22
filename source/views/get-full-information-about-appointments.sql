CREATE OR REPLACE VIEW get_full_information_about_appointments AS
    SELECT
        p.first_name || ' ' || p.last_name AS patient_name,
        d.first_name || ' ' || d.last_name AS doctor_name,
        b.name AS building_name,
        cabinet_number,
        reason,
        time AS appointment_time,
        duration_minutes
    FROM doctor_appointment da
        JOIN doctor d ON doctor_id = d.id
        JOIN patient p ON patient_id = p.id
        JOIN building b ON building_id = b.id
    WHERE is_closed = false;


SELECT * FROM get_full_information_about_appointments;