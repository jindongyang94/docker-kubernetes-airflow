
create table hubble_safety_permit_changes
(
"client_server_id" smallint,
"id" integer,
"permit_id" integer,
"agent_type" integer,
"agent_id" integer,
"remarks" character varying,
"action_taken" integer,
"validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
