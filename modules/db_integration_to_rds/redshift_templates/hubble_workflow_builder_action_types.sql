
create table hubble_workflow_builder_action_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(10),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"description" varchar(1),
"action_type_group_id" bigint,
"is_positive" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
