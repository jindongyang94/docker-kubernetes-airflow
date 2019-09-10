
create table hubble_job_queues
(
"client_server_id" smallint,
"id" integer,
"status" integer,
"queue" text,
"job_type" integer,
"last_error" text,
"run_at" timestamp without time zone,
"handler" text,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"job_class" text,
"dirty" boolean,
"retries" integer
)
