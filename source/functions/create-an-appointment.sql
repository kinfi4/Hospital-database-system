CREATE OR REPLACE FUNCTION create_appointment(doctor_id INT, patient_id INT, appointment_time TIMESTAMP, appointment_reason TEXT, appointment_duration_minutes INT)
    RETURNS VOID
    LANGUAGE plpgsql
    AS
$create_appoint$
    DECLARE doctor_hospital_id INT;
    DECLARE free_cabinets INT ARRAY;
    DECLARE free_cabinets_array_length INT;
    DECLARE random_cabinet_number INT;

    BEGIN
        SELECT hospital_id
            INTO doctor_hospital_id
        FROM doctor
            JOIN department d on doctor.department_id = d.id
            JOIN hospital h on d.hospital_id = h.id
        WHERE doctor.id = doctor_id;

        free_cabinets := ARRAY(
                        SELECT
                            da.cabinet_number
                        FROM doctor_appointment da
                        WHERE da.hospital_id = doctor_hospital_id AND da.is_closed = False AND (
                            appointment_time < time OR
                            appointment_time > (time + (appointment_duration_minutes || ' minutes')::INTERVAL)
                        )
        );

        SELECT array_length(free_cabinets, 1)
            INTO free_cabinets_array_length;

        SELECT free_cabinets[get_random_integer(1, free_cabinets_array_length)]
            INTO random_cabinet_number;

        INSERT INTO doctor_appointment(patient_id, doctor_id, hospital_id, cabinet_number, time, reason, is_closed, duration_minutes)
            VALUES
        ($2, $1, doctor_hospital_id, random_cabinet_number, appointment_time, appointment_reason, False, appointment_duration_minutes);
    END
$create_appoint$
