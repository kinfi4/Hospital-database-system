-----------------------------------------------
--- Get departments per buildings
-----------------------------------------------

SELECT
    building.name AS building_name,
    building.address,
    d.name AS department_name
FROM building
    JOIN department d ON building.id = building_id
ORDER BY building.name, address, department_name;
