
create table hubble_workflow_builder_states
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"name" varchar(36),
"description" varchar(1),
"state_type" varchar(13),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"action_type_group_id" bigint,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
