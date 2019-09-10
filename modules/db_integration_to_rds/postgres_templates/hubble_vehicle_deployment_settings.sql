
create table hubble_vehicle_deployment_settings
(
"client_server_id" smallint,
"id" integer,
"distance_cost" integer,
"waiting_cost" integer,
"max_waiting_time_origin" integer,
"max_waiting_time_destination" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"minimum_number_of_days_since_last_deployment" integer
)
