CREATE OR REPLACE FUNCTION get_free_cabinets(building_id INT, for_time TIMESTAMP, duration_minutes INT)
    RETURNS TABLE (cabinet_number INT)
    LANGUAGE plpgsql
    AS
$$
    BEGIN
        RETURN QUERY
        SELECT
            da.cabinet_number
        FROM doctor_appointment da
        WHERE da.building_id = $1 AND da.is_closed = False AND (
            $2 < time OR
            $2 > (time + ($3 || ' minutes')::INTERVAL)
        );
    END;
$$