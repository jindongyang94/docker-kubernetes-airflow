
create table hubble_tonnages_service_types
(
"client_server_id" smallint,
"id" integer,
"code" varchar(1),
"name" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
