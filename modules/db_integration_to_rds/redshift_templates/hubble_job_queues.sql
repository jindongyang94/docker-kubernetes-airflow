
create table hubble_job_queues
(
"client_server_id" smallint,
"id" integer,
"status" integer,
"queue" varchar(34),
"job_type" integer,
"last_error" varchar(23533),
"run_at" timestamp without time zone,
"handler" varchar(8445813),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"job_class" varchar(88),
"dirty" boolean,
"retries" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
