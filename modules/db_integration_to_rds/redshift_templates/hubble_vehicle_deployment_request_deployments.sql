
create table hubble_vehicle_deployment_request_deployments
(
"client_server_id" smallint,
"id" integer,
"deployment_id" integer,
"vehicle_type_request_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
