
create table hubble_workflow_builder_groups
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"name" varchar(73),
"group_type" varchar(16),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
