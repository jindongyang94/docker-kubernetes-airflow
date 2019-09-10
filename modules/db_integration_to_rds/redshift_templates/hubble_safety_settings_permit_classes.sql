
create table hubble_safety_settings_permit_classes
(
"client_server_id" smallint,
"id" integer,
"name" varchar(249),
"description" varchar(276),
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
