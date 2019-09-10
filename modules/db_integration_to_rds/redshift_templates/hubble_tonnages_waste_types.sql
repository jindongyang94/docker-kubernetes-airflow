
create table hubble_tonnages_waste_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(1),
"code" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
