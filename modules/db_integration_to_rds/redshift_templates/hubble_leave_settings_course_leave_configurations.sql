
create table hubble_leave_settings_course_leave_configurations
(
"client_server_id" smallint,
"id" integer,
"application_period" integer,
"course_leave_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
