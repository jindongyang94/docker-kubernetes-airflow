
create table hubble_workflow_builder_actions
(
"client_server_id" smallint,
"id" integer,
"workflow_id" bigint,
"name" varchar(46),
"description" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"action_type_id" bigint,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
