
create table hubble_leave_step_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" character varying,
"metadata" text,
"sort_key" integer,
"step_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
