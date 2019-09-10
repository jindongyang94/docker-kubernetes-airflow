
create table hubble_task_assignment_unit_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(72),
"sample_size" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"project_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
