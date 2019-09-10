
create table hubble_workflow_builder_logs
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"request_id" integer,
"action_id" integer,
"remarks" character varying,
"log_type" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
