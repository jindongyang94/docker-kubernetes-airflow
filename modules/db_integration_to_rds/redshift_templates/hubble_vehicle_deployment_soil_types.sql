
create table hubble_vehicle_deployment_soil_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(46),
"code" varchar(39),
"density" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
