
create table hubble_workflow_builder_request_actions
(
"client_server_id" smallint,
"id" integer,
"request_id" bigint,
"action_id" bigint,
"transition_id" bigint,
"is_active" boolean,
"is_completed" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
