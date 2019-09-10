
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
"mode" varchar(12),
"assignment_remarks" varchar(222),
"approver_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
