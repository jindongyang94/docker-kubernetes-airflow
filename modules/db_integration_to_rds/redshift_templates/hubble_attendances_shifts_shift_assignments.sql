
create table hubble_attendances_shifts_shift_assignments
(
"client_server_id" smallint,
"id" integer,
"shift_id" integer,
"workforces_profile_id" integer,
"shift_start_time" timestamp without time zone,
"shift_end_time" timestamp without time zone,
"date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"schedule_id" integer,
"late_attendance_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
