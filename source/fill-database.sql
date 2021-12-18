COPY building
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/building.csv'
DELIMITER ','
CSV HEADER;

COPY department
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/departments.csv'
DELIMITER ','
CSV HEADER;

COPY doctor_specialization
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/doctor-specializations.csv'
DELIMITER ','
CSV HEADER;

COPY doctor_timetable
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/timetables.csv'
DELIMITER ','
CSV HEADER;

COPY cabinet
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/cabinets.csv'
DELIMITER ','
CSV HEADER;

COPY patient
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/patients.csv'
DELIMITER ','
CSV HEADER;

COPY doctor
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/doctors.csv'
DELIMITER ','
CSV HEADER;

COPY equipment
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/equipment.csv'
DELIMITER ','
CSV HEADER;

COPY medical_procedure(id,time,duration_minutes,equipment_id,patient_id)
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/medical-procedures.csv'
DELIMITER ','
CSV HEADER;

COPY doctor_appointment(id,patient_id,doctor_id,time,duration_minutes,building_id,cabinet_number,reason,is_closed)
FROM '/home/kinfi4/Documents/db/hospital-database-system/source/data/doctor-appointments.csv'
DELIMITER ','
CSV HEADER;
