
create table hubble_tonnages_vehicles
(
"client_server_id" smallint,
"id" integer,
"vehicle_number" text,
"driver_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"brand" text,
"model" text,
"purchase_date" date,
"last_service_date" date,
"next_service_date" date,
"vehicle_type_id" integer
)
