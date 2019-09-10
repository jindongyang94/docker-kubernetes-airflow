
create table hubble_task_assignment_ot_request_logs
(
"client_server_id" smallint,
"id" integer,
"task_id" integer,
"profile_id" integer,
"action" integer,
"remarks" varchar(6),
"signature" varchar(256),
"performed_at" timestamp without time zone,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
