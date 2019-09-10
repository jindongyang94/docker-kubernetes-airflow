
create table hubble_workflow_builder_action_type_groups
(
"client_server_id" smallint,
"id" integer,
"name" varchar(25),
"description" varchar(144),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
