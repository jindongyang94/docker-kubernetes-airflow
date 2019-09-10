
create table hubble_math_geo_fences
(
"client_server_id" smallint,
"id" integer,
"geo_fence_type" integer,
"circle_radius" double precision,
"center_latitude" double precision,
"center_longitude" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
