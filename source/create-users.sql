CREATE USER hospital_viewer WITH ENCRYPTED PASSWORD 'easy-password';
GRANT SELECT ON ALL TABLES IN SCHEMA hospitalsystem.public TO hospital_viewer;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA hospitalsystem.public TO hospital_viewer;

CREATE USER hospital_admin WITH ENCRYPTED PASSWORD 'hard-password';
GRANT ALL PRIVILEGES ON DATABASE hospitalsystem TO hospital_admin;
