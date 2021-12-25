-----------------------------------------------
--- Count appointments of every surgery
-----------------------------------------------

SELECT
    doc.first_name,
    ds.name,
    da.time,
    da.reason
FROM doctor doc
    JOIN doctor_specialization ds ON specialization_id = ds.id
    JOIN doctor_appointment da ON doc.id = doctor_id
WHERE ds.name = 'Хирург'
ORDER BY time;
