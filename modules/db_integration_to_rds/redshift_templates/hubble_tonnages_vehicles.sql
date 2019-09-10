
create table hubble_tonnages_vehicles
(
"client_server_id" smallint,
"id" integer,
"vehicle_number" varchar(1),
"driver_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"brand" varchar(1),
"model" varchar(1),
"purchase_date" date,
"last_service_date" date,
"next_service_date" date,
"vehicle_type_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
