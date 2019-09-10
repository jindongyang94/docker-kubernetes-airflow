
create table hubble_vehicle_deployment_clients
(
"client_server_id" smallint,
"id" integer,
"company_name" varchar(9),
"company_code" varchar(9),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"address1" varchar(1),
"address2" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
