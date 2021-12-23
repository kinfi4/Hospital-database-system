-----------------------------------------------
--- Counting the number of doctors for each
--- specialization
-----------------------------------------------

SELECT
    ds.name AS specializatoin_name,
    count(*) AS number_of_specialists
FROM doctor doc
    JOIN doctor_specialization ds ON doc.specialization_id = ds.id
GROUP BY ds.name
ORDER BY number_of_specialists DESC;