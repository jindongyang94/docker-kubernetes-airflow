
create table hubble_quality_wi_request_changes
(
"client_server_id" smallint,
"id" integer,
"wi_request_id" integer,
"qa_agent_id" integer,
"remarks" character varying,
"action_taken" integer,
"validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
