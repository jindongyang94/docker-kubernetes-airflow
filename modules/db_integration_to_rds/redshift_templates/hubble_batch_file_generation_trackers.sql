
create table hubble_batch_file_generation_trackers
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"report_type" varchar(10),
"result_extension" integer,
"status" integer,
"total_count" integer,
"completed_count" integer,
"file_name" varchar(132),
"s3_directory" varchar(211),
"error_msg" varchar(66),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
