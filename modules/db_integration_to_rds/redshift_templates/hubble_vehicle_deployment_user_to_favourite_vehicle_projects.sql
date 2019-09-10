
create table hubble_vehicle_deployment_user_to_favourite_vehicle_projects
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"vehicle_project_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
