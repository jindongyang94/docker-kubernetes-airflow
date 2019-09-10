
create table hubble_workflow_builder_request_data
(
"client_server_id" smallint,
"id" integer,
"request_id" bigint,
"name" varchar(1),
"value" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
