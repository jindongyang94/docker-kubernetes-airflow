
create table hubble_safety_permit_logs
(
"client_server_id" smallint,
"id" integer,
"action" character varying,
"remark" character varying,
"user_id" integer,
"permit_id" integer,
"validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
