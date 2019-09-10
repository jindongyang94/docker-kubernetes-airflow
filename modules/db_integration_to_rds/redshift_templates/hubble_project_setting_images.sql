
create table hubble_project_setting_images
(
"client_server_id" smallint,
"id" integer,
"imageable_id" integer,
"imageable_type" varchar(49),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"attachment" varchar(126),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
