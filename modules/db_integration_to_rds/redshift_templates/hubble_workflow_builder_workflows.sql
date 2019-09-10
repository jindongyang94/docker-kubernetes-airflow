
create table hubble_workflow_builder_workflows
(
"client_server_id" smallint,
"id" integer,
"name" varchar(19),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"is_deleted" boolean,
"status" varchar(7),
"creator_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
