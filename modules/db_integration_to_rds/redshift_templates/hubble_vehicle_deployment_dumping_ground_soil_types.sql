
create table hubble_vehicle_deployment_dumping_ground_soil_types
(
"client_server_id" smallint,
"id" integer,
"dumping_ground_id" integer,
"soil_type_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
