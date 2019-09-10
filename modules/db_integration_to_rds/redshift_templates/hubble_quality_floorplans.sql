
create table hubble_quality_floorplans
(
"client_server_id" smallint,
"id" integer,
"zone" varchar(58),
"floor" varchar(19),
"unit" varchar(22),
"x" double precision,
"y" double precision,
"width" double precision,
"height" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"location_image_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
