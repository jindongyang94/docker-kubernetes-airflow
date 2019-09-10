
create table hubble_batch_file_generation_trackers
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"report_type" text,
"result_extension" integer,
"status" integer,
"total_count" integer,
"completed_count" integer,
"file_name" text,
"s3_directory" text,
"error_msg" text,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
