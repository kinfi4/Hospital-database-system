CREATE OR REPLACE FUNCTION check_uniques_of_appointment_func()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS
$check_uniques_appointment$
    DECLARE error_message VARCHAR(255);

    BEGIN
        SELECT concat(
                'Patient: ',
                New.patient_id::VARCHAR, ' cant have an appointment with doctor: ',
                New.doctor_id::VARCHAR, ' at ',
                New.time::VARCHAR, ' because cabinet is busy at that moment or doctor or patient is having another appointment at that time'
            ) INTO error_message;

        IF exists(
            SELECT 1 FROM doctor_appointment
            WHERE (doctor_id = New.doctor_id OR patient_id = New.patient_id OR (New.cabinet_number = cabinet_number AND New.hospital_id = hospital_id))
                    AND New.time >= time
                    AND New.time <= (time + (duration_minutes || ' minutes')::INTERVAL)
                    AND is_closed = False
        )
        THEN
            SELECT raise_error(error_message);
        END IF;

        RETURN NEW;
    END;
$check_uniques_appointment$;

CREATE TRIGGER check_uniques_of_appointment BEFORE INSERT OR UPDATE ON doctor_appointment
    FOR EACH ROW EXECUTE PROCEDURE check_uniques_of_appointment_func()