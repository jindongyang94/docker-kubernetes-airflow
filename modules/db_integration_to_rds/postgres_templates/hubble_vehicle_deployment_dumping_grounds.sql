
create table hubble_vehicle_deployment_dumping_grounds
(
"client_server_id" smallint,
"id" integer,
"name" text,
"code" text,
"address" text,
"address2" text,
"latitude" double precision,
"longitude" double precision,
"managed_by" text,
"number_of_vehicle" integer,
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"country" character varying,
"geo_fence_id" integer
)
