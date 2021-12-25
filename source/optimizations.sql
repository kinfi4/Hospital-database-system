CREATE INDEX ON doctor USING btree (first_name);
CREATE INDEX ON doctor_appointment USING btree (time DESC);
CREATE INDEX ON equipment USING btree (model);
CREATE INDEX ON doctor_specialization USING btree (name);
CREATE INDEX ON building USING btree (name);