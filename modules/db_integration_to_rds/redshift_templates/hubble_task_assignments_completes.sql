
create table hubble_task_assignments_completes
(
"client_server_id" smallint,
"id" integer,
"agg_productivity_id" integer,
"unit_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
