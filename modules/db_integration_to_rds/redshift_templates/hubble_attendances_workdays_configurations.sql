
create table hubble_attendances_workdays_configurations
(
"client_server_id" smallint,
"id" integer,
"work_start_time" varchar(8),
"work_end_time" varchar(8),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
