CREATE USER hospital_admin WITH ENCRYPTED PASSWORD 'admin-password';
GRANT ALL PRIVILEGES ON DATABASE hospitalsystem TO hospital_admin;

CREATE USER hospital_patient WITH ENCRYPTED PASSWORD 'patient-password';
GRANT INSERT ON TABLE doctor_appointment TO hospital_patient;
GRANT SELECT ON TABLE medical_procedure, doctor_appointment, doctor_timetable TO hospital_patient;

CREATE USER hospital_doctor WITH ENCRYPTED PASSWORD 'doctor-password';
GRANT INSERT, SELECT, UPDATE ON TABLE patient, doctor_appointment, medical_procedure TO hospital_doctor;
GRANT SELECT ON TABLE doctor_timetable TO hospital_doctor;
