
create table hubble_job_progress_trackers
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"job_type" text,
"result_id" integer,
"status" integer,
"total_count" integer,
"completed_count" integer,
"result_name" text,
"result_directory" text,
"error_msg" text,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"error_stacktrace" character varying
)
