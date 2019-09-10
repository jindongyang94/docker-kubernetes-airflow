
create table hubble_task_assignment_ot_request_logs
(
"client_server_id" smallint,
"id" integer,
"task_id" integer,
"profile_id" integer,
"action" integer,
"remarks" character varying,
"signature" bytea,
"performed_at" timestamp without time zone,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
