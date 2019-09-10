
create table hubble_task_assignment_tasks
(
"client_server_id" smallint,
"id" integer,
"job_type_id" integer,
"location_id" integer,
"worker_id" integer,
"assigner_id" integer,
"start_time" timestamp without time zone,
"target_end_time" timestamp without time zone,
"actual_end_time" timestamp without time zone,
"duration" numeric,
"remarks" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
"ot_target_end_time" timestamp without time zone,
"ot_request_status" integer,
"task_type" integer
)
