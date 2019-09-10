
create table hubble_job_progress_trackers
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"job_type" varchar(24),
"result_id" integer,
"status" integer,
"total_count" integer,
"completed_count" integer,
"result_name" varchar(102),
"result_directory" varchar(172),
"error_msg" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"error_stacktrace" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
