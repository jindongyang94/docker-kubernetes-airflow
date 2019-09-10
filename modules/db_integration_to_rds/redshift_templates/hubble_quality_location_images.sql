
create table hubble_quality_location_images
(
"client_server_id" smallint,
"id" integer,
"image" varchar(147),
"identifier" varchar(121),
"project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
