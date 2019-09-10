
create table hubble_leave_settings_childcare_leave_configurations
(
"client_server_id" smallint,
"id" integer,
"application_period" integer,
"start_age_in_months" integer,
"end_age_in_months" integer,
"childcare_leave_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
