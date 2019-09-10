
create table hubble_workflow_builder_activity_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(37),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
