
create table hubble_machineries_assignments_user_to_favourite_vehicles
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"vehicle_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
