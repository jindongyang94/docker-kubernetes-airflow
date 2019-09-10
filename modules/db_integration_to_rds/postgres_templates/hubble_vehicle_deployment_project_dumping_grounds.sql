
create table hubble_vehicle_deployment_project_dumping_grounds
(
"client_server_id" smallint,
"id" integer,
"dumping_ground_id" integer,
"vehicle_project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"dg_to_site" character varying,
"site_to_dg" character varying
)
