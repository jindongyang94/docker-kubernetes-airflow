
create table hubble_job_queues_job_buffers
(
"client_server_id" smallint,
"id" integer,
"class_name" character varying,
"arguments" text,
"cron" character varying,
"last_error" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
