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

        IF New.is_closed = True -- that means we are trying to close the appointment
        THEN
           RETURN new;
        END IF;

        IF exists(
            SELECT 1 FROM doctor_appointment
            WHERE (doctor_id = New.doctor_id OR patient_id = New.patient_id OR (New.cabinet_number = cabinet_number AND New.building_id = building_id))
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
    FOR EACH ROW EXECUTE PROCEDURE check_uniques_of_appointment_func();


INSERT INTO doctor_appointment (id, patient_id, doctor_id, building_id, cabinet_number, time, reason, is_closed, duration_minutes) VALUES
(100, 1, 7, 3, 149, '2021-11-30 15:18:51.593000', 'some reason', false, 23);