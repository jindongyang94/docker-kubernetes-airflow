
create table hubble_leave_step_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" varchar(12),
"metadata" varchar(3),
"sort_key" integer,
"step_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
