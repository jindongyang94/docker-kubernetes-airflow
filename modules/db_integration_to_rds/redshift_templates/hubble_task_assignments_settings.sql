
create table hubble_task_assignments_settings
(
"client_server_id" smallint,
"id" integer,
"manday_hours" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
