
create table hubble_leave_settings_sick_outpatient_leave_configurations
(
"client_server_id" smallint,
"id" integer,
"application_period" integer,
"sick_outpatient_leave_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
