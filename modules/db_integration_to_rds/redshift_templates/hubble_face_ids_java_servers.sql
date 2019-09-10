
create table hubble_face_ids_java_servers
(
"client_server_id" smallint,
"id" integer,
"name" varchar(16),
"password_digest" varchar(90),
"endpoint_to_rails" varchar(40),
"ip_to_devices" varchar(22),
"port_to_devices" varchar(6),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
