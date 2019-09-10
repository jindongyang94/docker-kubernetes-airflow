
create table hubble_machineries_vehicles
(
"client_server_id" smallint,
"id" integer,
"driver_id" integer,
"model_id" integer,
"vehicle_number" varchar(13),
"purchase_date" date,
"last_service_date" date,
"next_service_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
