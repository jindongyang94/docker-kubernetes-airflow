
create table hubble_workflow_builder_state_activity_types
(
"client_server_id" smallint,
"id" integer,
"state_id" bigint,
"activity_type_id" bigint,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
