
create table hubble_task_assignments_ua_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" character varying,
"metadata" json,
"sort_key" integer,
"unit_assignment_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
