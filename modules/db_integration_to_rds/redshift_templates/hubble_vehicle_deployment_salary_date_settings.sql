
create table hubble_vehicle_deployment_salary_date_settings
(
"client_server_id" smallint,
"id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"effective_start_date" date,
"effective_end_date" date,
"salary_date_start_time" varchar(8),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
