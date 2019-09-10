
create table hubble_workflow_builder_logs
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"request_id" integer,
"action_id" integer,
"remarks" varchar(1),
"log_type" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
