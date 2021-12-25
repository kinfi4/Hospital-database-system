-----------------------------------------------
--- Get all available cabinets for
--- 2022-01-25 10:27:49.203000 for duration of 10 minutes
--- for building named by Makarov
-----------------------------------------------

SELECT
    cabinet_number AS free_cabinet
FROM get_free_cabinets((SELECT id FROM building WHERE building.name = 'Building named by Makarov'),
                         '2022-01-25 10:27:49.203000',
                   10)
ORDER BY free_cabinet;