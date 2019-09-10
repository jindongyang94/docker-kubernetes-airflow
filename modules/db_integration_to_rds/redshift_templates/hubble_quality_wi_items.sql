
create table hubble_quality_wi_items
(
"client_server_id" smallint,
"id" integer,
"name" varchar(201),
"type_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
