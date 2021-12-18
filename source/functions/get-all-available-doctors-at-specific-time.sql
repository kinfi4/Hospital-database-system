CREATE OR REPLACE FUNCTION get_all_available_doctors_at_specific_time(for_time TIMESTAMP)
    RETURNS TABLE (doctor_id INT, doctor_name VARCHAR, doctor_timetable VARCHAR)
    LANGUAGE plpgsql
    AS
$$
    DECLARE row RECORD;

    BEGIN
        IF (extract(ISODOW FROM for_time)::INT IN (6, 7))
        THEN
            RAISE EXCEPTION 'Dont try to fool me, its a weekend';
        END IF;

        FOR row IN
            SELECT
                doc.id AS doc_id,
                doc.first_name AS doc_name,
                get_doctor_timetable(doc.id, extract(ISODOW FROM for_time)::INT) AS timetable
            FROM doctor doc
        LOOP
            IF (
                  (
                      extract(HOUR FROM for_time) > substr(row.timetable, 1, 2)::INT
                        OR (extract(HOUR FROM for_time) = substr(row.timetable, 1, 2)::INT AND extract(MINUTE FROM for_time) >= substr(row.timetable, 4, 2)::INT)
                  )
                  AND
                  (
                      extract(HOUR FROM for_time) < substr(row.timetable, 7, 2)::INT
                        OR (extract(HOUR FROM for_time) = substr(row.timetable, 7, 2)::INT AND extract(MINUTE FROM for_time) <= substr(row.timetable, 10, 2)::INT)
                  )
            ) THEN
                doctor_id := row.doc_id;
                doctor_name := row.doc_name;
                doctor_timetable := row.timetable;

                RETURN NEXT;
              ELSE
                RAISE INFO 'Doctor timetable: %', row.timetable;
            END IF;
        END LOOP;
    END;
$$;


SELECT * FROM get_all_available_doctors_at_specific_time('2022-04-05T08:15:43.258Z'::TIMESTAMP)