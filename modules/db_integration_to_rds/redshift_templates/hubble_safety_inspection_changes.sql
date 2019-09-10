
create table hubble_safety_inspection_changes
(
"client_server_id" smallint,
"id" integer,
"inspection_id" integer,
"agent_id" integer,
"remarks" varchar(1),
"action_taken" integer,
"validation" varchar(256),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
