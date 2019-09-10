
create table hubble_quality_qa_request_changes
(
"client_server_id" smallint,
"id" integer,
"qa_request_id" integer,
"agent_type" integer,
"agent_id" integer,
"remarks" character varying,
"action_taken" integer,
"validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
