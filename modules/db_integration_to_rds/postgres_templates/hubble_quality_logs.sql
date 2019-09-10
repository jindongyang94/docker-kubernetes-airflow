
create table hubble_quality_logs
(
"client_server_id" smallint,
"id" integer,
"action" character varying,
"remark" character varying,
"loggable_id" integer,
"loggable_type" character varying,
"user_id" integer,
"validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
