
create table hubble_attendances_workdays_configuration_assignments
(
"client_server_id" smallint,
"id" integer,
"workdays_configuration_id" integer,
"workdays_configuration_group_id" integer,
"weekday" smallint,
"shift" smallint,
"holiday" smallint,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"unit" numeric
)
