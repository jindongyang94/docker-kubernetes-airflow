
create table hubble_machineries_vehicle_brands
(
"client_server_id" smallint,
"id" integer,
"name" varchar(15),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
