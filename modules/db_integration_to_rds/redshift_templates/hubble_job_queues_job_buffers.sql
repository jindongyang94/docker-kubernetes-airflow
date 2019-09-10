
create table hubble_job_queues_job_buffers
(
"client_server_id" smallint,
"id" integer,
"class_name" varchar(1),
"arguments" varchar(1),
"cron" varchar(1),
"last_error" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
