
create table hubble_workflow_builder_states
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"name" character varying,
"description" character varying,
"state_type" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"action_type_group_id" bigint
)
