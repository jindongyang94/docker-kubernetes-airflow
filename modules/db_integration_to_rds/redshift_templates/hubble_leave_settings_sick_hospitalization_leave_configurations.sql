
create table hubble_leave_settings_sick_hospitalization_leave_configurations
(
"client_server_id" smallint,
"id" integer,
"application_period" integer,
"sick_hospitalization_leave_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
