
create table hubble_task_assignments_agg_productivities
(
"client_server_id" smallint,
"id" integer,
"team_id" integer,
"job_type_id" integer,
"total_minutes" integer,
"date" timestamp without time zone,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
