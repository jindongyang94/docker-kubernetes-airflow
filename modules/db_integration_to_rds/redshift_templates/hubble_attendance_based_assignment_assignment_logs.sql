
create table hubble_attendance_based_assignment_assignment_logs
(
"client_server_id" smallint,
"id" integer,
"assignment_id" integer,
"profile_id" integer,
"remarks" varchar(108),
"log_type" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
