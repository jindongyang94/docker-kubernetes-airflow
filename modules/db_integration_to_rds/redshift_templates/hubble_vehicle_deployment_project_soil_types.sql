
create table hubble_vehicle_deployment_project_soil_types
(
"client_server_id" smallint,
"id" integer,
"vehicle_project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"soil_type_id" integer,
"default" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
