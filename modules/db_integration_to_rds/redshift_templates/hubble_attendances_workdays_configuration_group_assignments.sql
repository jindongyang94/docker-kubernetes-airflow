
create table hubble_attendances_workdays_configuration_group_assignments
(
"client_server_id" smallint,
"id" integer,
"workforces_profile_id" integer,
"workdays_configuration_group_id" integer,
"effective_start_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"effective_end_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
