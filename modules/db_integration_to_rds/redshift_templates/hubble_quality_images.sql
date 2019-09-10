
create table hubble_quality_images
(
"client_server_id" smallint,
"id" integer,
"imageable_id" integer,
"imageable_type" varchar(45),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"attachment" varchar(10),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
