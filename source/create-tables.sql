CREATE TABLE IF NOT EXISTS Building (
    id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    building_id INT NOT NULL,

    CONSTRAINT fk_on_building
        FOREIGN KEY (building_id) REFERENCES Building (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Equipment (
    id SERIAL PRIMARY KEY,
    model VARCHAR(255) NOT NULL,
    department_id INT NULL,

    CONSTRAINT fk_on_department
        FOREIGN KEY (department_id) REFERENCES department (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Doctor_specialization (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Patient (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NULL,
    sex VARCHAR(10) NULL,

    CONSTRAINT check_sex
        CHECK (sex = 'male' OR sex = 'female'),
    CONSTRAINT check_age
        CHECK (age > 0 AND age < 150)
);

CREATE TABLE IF NOT EXISTS Cabinet (
    building_id INT NOT NULL,
    number INT NOT NULL,

    PRIMARY KEY (building_id, number)
);

CREATE TABLE IF NOT EXISTS Doctor(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    experience INT NULL,

    specialization_id INT NULL,
    department_id INT NULL,
    timetable_id INT NULL,

    FOREIGN KEY (specialization_id) REFERENCES Doctor_specialization (id),
    FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE IF NOT EXISTS Doctor_timetable (
    id SERIAL PRIMARY KEY,
    monday_timetable VARCHAR(255),
    tuesday_timetable VARCHAR(255),
    wednesday_timetable VARCHAR(255),
    thursday_timetable VARCHAR(255),
    friday_timetable VARCHAR(255)
);

ALTER TABLE Doctor
ADD CONSTRAINT fk_on_timetable
FOREIGN KEY (timetable_id) REFERENCES Doctor_timetable(id);

CREATE TABLE IF NOT EXISTS Medical_procedure (
    id SERIAL PRIMARY KEY,
    equipment_id INT NOT NULL,
    time TIMESTAMP NOT NULL,
    duration_minutes INT NOT NULL,
    patient_id INT NOT NULL,

    FOREIGN KEY (equipment_id) REFERENCES Equipment (id),
    FOREIGN KEY (patient_id) REFERENCES Patient (id)
);

CREATE TABLE IF NOT EXISTS Doctor_appointment (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    building_id INT NOT NULL,
    cabinet_number INT NOT NULL,
    time TIMESTAMP NOT NULL,
    reason TEXT NULL,
    is_closed BOOL DEFAULT FALSE,
    duration_minutes INT NOT NULL,

    FOREIGN KEY (patient_id) REFERENCES Patient(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(id),
    FOREIGN KEY (building_id, cabinet_number) REFERENCES Cabinet(building_id, number)
);
