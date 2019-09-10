
create table hubble_task_assignment_locations
(
"client_server_id" smallint,
"id" integer,
"zone" character varying,
"floor" character varying,
"unit" character varying,
"unit_type_id" integer,
"bca_score" numeric,
"completion_status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"completion_date" date
)
