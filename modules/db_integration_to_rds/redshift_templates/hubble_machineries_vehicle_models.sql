
create table hubble_machineries_vehicle_models
(
"client_server_id" smallint,
"id" integer,
"vehicle_brand_id" integer,
"vehicle_type_id" integer,
"name" varchar(19),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
