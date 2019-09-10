
create table hubble_attendances_workdays_configuration_groups
(
"client_server_id" smallint,
"id" integer,
"name" varchar(46),
"effective_start_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"effective_end_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
