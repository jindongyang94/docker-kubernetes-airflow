
create table hubble_attendances_caches_attendance_records
(
"client_server_id" smallint,
"id" integer,
"salary_date" date,
"overtime_sequence" integer,
"hours" numeric,
"shift_assignment_id" integer,
"team_id" integer,
"overtime_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
