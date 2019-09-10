
create table hubble_vehicle_deployment_deployments
(
"client_server_id" smallint,
"id" integer,
"vehicle_id" integer,
"sequence" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"load_to_dumping_ground_id" integer,
"load_to_gate_id" integer,
"load_transit_id" integer,
"load_from_id" integer,
"soil_type_id" integer,
"status" integer,
"cancel_reason" character varying,
"cancel_time" timestamp without time zone,
"cancel_user_id" integer
)
