
create table hubble_task_assignments_unit_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(72),
"sample_size" integer,
"project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
