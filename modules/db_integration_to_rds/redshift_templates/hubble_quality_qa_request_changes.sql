
create table hubble_quality_qa_request_changes
(
"client_server_id" smallint,
"id" integer,
"qa_request_id" integer,
"agent_type" integer,
"agent_id" integer,
"remarks" varchar(108),
"action_taken" integer,
"validation" varchar(256),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
