
create table hubble_vehicle_deployment_blacklist_records
(
"client_server_id" smallint,
"id" integer,
"vehicle_project_id" integer,
"driver_id" integer,
"vehicle_id" integer,
"date_start" date,
"date_end" date,
"remarks" text,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"blacklist_reason_id" integer
)
