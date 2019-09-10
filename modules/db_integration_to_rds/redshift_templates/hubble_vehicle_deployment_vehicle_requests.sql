
create table hubble_vehicle_deployment_vehicle_requests
(
"client_server_id" smallint,
"id" integer,
"soil_type_id" integer,
"ref_num" varchar(93),
"remarks" varchar(1),
"is_backfilled" boolean,
"date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"creator_id" integer,
"load_to_dumping_ground_id" integer,
"load_to_gate_id" integer,
"load_from_id" integer,
"load_transit_id" integer,
"request_time" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
