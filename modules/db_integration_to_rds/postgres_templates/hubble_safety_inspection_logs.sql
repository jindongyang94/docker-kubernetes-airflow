
create table hubble_safety_inspection_logs
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"inspection_id" integer,
"validation" bytea,
"remark" character varying,
"action" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
