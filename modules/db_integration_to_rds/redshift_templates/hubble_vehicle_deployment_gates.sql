
create table hubble_vehicle_deployment_gates
(
"client_server_id" smallint,
"id" integer,
"vehicle_project_id" integer,
"name" varchar(52),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"default" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
