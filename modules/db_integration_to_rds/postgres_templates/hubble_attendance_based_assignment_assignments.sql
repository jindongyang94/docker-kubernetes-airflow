
create table hubble_attendance_based_assignment_assignments
(
"client_server_id" smallint,
"id" integer,
"attendance_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
"rating" numeric,
"total_tasks_assigned" integer,
"total_tasks_verified" integer,
"total_tasks_pending_verification" integer,
"total_tasks_pending_ot" integer,
"total_tasks_approved_ot" integer,
"total_tasks_rejected_ot" integer
)
