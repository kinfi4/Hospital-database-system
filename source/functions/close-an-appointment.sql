CREATE OR REPLACE FUNCTION close_appointment(appointment_id INT)
    RETURNS VOID
    LANGUAGE plpgsql
    AS
$close_appointment$
    BEGIN
        UPDATE doctor_appointment
        SET is_closed = True
        WHERE id = appointment_id;
    END;
$close_appointment$;
