
create table hubble_task_assignments_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" varchar(37),
"metadata" varchar(256),
"sort_key" integer,
"assignment_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
