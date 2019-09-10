
create table hubble_quality_inspection_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(19),
"status" varchar(7),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
