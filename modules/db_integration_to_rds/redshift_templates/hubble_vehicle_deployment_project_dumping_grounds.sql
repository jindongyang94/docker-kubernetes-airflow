
create table hubble_vehicle_deployment_project_dumping_grounds
(
"client_server_id" smallint,
"id" integer,
"dumping_ground_id" integer,
"vehicle_project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"dg_to_site" varchar(12),
"site_to_dg" varchar(12),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
