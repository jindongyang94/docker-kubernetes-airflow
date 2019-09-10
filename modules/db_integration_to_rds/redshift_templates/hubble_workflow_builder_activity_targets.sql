
create table hubble_workflow_builder_activity_targets
(
"client_server_id" smallint,
"id" integer,
"activity_id" bigint,
"group_id" bigint,
"target_type" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"cc_list_id" bigint,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
