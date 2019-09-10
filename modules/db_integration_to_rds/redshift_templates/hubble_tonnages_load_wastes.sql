
create table hubble_tonnages_load_wastes
(
"client_server_id" smallint,
"id" integer,
"load_id" integer,
"waste_type_id" integer,
"weight" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
