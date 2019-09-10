
create table hubble_quality_rectification_reviews
(
"client_server_id" smallint,
"id" integer,
"rectification_id" integer,
"remark" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"user_id" integer,
"extended_deadline" timestamp without time zone
)
