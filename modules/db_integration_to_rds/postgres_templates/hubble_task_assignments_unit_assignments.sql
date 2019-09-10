
create table hubble_task_assignments_unit_assignments
(
"client_server_id" smallint,
"id" integer,
"job_type_id" integer,
"unit_id" integer,
"target" integer,
"actual" integer,
"assignment_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"start_time" timestamp without time zone,
"target_end_time" timestamp without time zone,
"end_time" timestamp without time zone,
"is_ot" bigint,
"unit_assignment_remarks" text
)
