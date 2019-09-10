
create table hubble_leave_settings_award_schedules
(
"client_server_id" smallint,
"id" integer,
"start" integer,
"end" integer,
"quantity" numeric,
"leave_configuration_type" varchar(73),
"leave_configuration_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
