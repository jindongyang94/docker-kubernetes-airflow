
create table hubble_attendances_attendance_remarks
(
"client_server_id" smallint,
"id" integer,
"attendance_date" date,
"remark" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"profile_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
