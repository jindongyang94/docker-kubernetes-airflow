
create table hubble_vehicle_deployment_ticket_attachments
(
"client_server_id" smallint,
"id" integer,
"ticket_info_id" integer,
"attachment" varchar(21),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
