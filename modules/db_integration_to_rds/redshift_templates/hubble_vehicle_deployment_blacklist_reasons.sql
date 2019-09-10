
create table hubble_vehicle_deployment_blacklist_reasons
(
"client_server_id" smallint,
"id" integer,
"name" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
