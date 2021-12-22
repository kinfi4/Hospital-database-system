CREATE INDEX ON doctor USING btree (first_name);
CREATE INDEX ON doctor_appointment USING btree (time DESC);
CREATE INDEX ON equipment USING btree (model);

