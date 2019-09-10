
create table hubble_workflow_builder_transitions
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"current_state_id" bigint,
"next_state_id" bigint,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"action_id" bigint,
"transition_type" varchar(12),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
