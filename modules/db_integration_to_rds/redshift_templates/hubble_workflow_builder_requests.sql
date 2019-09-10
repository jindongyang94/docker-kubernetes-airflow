
create table hubble_workflow_builder_requests
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"user_id" bigint,
"current_state_id" bigint,
"requested_at" timestamp without time zone,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"submission_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
