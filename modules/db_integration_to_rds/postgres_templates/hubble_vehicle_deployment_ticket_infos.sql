
create table hubble_vehicle_deployment_ticket_infos
(
"client_server_id" smallint,
"id" integer,
"deployment_id" integer,
"start_time" timestamp without time zone,
"origin_in_time" timestamp without time zone,
"origin_out_time" timestamp without time zone,
"destination_in_time" timestamp without time zone,
"destination_out_time" timestamp without time zone,
"origin_in_latitude" double precision,
"origin_in_longitude" double precision,
"origin_out_latitude" double precision,
"origin_out_longitude" double precision,
"destination_in_latitude" double precision,
"destination_in_longitude" double precision,
"destination_out_latitude" double precision,
"destination_out_longitude" double precision,
"load_remarks" text,
"dumping_remarks" text,
"weight_in" numeric,
"weight_out" numeric,
"amount_paid" integer,
"origin_in_outside_geofence" boolean,
"origin_out_outside_geofence" boolean,
"destination_in_outside_geofence" boolean,
"destination_out_outside_geofence" boolean,
"delay_at_origin" boolean,
"delay_at_destination" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"start_trip_latitude" double precision,
"start_trip_longitude" double precision,
"transit_in_latitude" double precision,
"transit_in_longitude" double precision,
"transit_out_latitude" double precision,
"transit_out_longitude" double precision,
"transit_in_time" timestamp without time zone,
"transit_out_time" timestamp without time zone,
"transit_in_outside_geofence" boolean,
"transit_out_outside_geofence" boolean,
"driver_id" integer
)
