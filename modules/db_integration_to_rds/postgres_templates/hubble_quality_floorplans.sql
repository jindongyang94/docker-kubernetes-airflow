
create table hubble_quality_floorplans
(
"client_server_id" smallint,
"id" integer,
"zone" character varying,
"floor" character varying,
"unit" character varying,
"x" double precision,
"y" double precision,
"width" double precision,
"height" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"location_image_id" integer
)
