
create table hubble_vehicle_deployment_tickets
(
"client_server_id" smallint,
"id" integer,
"ref_num" varchar(93),
"ticket_info_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"ticket_type" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
