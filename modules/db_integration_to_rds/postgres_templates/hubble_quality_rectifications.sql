
create table hubble_quality_rectifications
(
"client_server_id" smallint,
"id" integer,
"rectifiable_type" character varying,
"rectifiable_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"remark" character varying,
"user_id" integer
)
