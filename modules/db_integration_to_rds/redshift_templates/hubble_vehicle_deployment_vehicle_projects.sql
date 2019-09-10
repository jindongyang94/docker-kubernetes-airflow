
create table hubble_vehicle_deployment_vehicle_projects
(
"client_server_id" smallint,
"id" integer,
"client_id" integer,
"volume" integer,
"manager" varchar(10),
"email" varchar(22),
"contact_no" varchar(12),
"licensed" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"project_id" integer,
"default_transit_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
