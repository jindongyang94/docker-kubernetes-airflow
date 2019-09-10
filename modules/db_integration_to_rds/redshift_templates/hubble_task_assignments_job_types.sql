
create table hubble_task_assignments_job_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(36),
"job_group_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
