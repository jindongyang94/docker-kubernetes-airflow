
create table hubble_machineries_vehicle_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(19),
"load_volume" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"overload_limit" integer,
"underload_limit" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
