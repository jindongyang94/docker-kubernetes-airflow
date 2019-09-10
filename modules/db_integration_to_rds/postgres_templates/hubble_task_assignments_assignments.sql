
create table hubble_task_assignments_assignments
(
"client_server_id" smallint,
"id" integer,
"incentive" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"is_target_done" boolean,
"is_actual_done" boolean,
"attendance_id" integer,
"mode" text,
"assignment_remarks" text,
"approver_id" integer
)
