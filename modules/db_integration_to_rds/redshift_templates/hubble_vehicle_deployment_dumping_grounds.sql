
create table hubble_vehicle_deployment_dumping_grounds
(
"client_server_id" smallint,
"id" integer,
"name" varchar(55),
"code" varchar(39),
"address" varchar(63),
"address2" varchar(1),
"latitude" double precision,
"longitude" double precision,
"managed_by" varchar(19),
"number_of_vehicle" integer,
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"country" varchar(13),
"geo_fence_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
