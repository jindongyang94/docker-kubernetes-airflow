
create table hubble_workflow_builder_action_targets
(
"client_server_id" smallint,
"id" integer,
"action_id" bigint,
"group_id" bigint,
"target_type" varchar(15),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"form_version_id" bigint,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
