
create table hubble_tonnages_load_attachments
(
"client_server_id" smallint,
"id" integer,
"load_id" integer,
"attachment" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type" varchar(1),
"bin_location" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
