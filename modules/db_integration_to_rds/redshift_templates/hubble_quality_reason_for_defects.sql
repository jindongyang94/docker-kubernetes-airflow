
create table hubble_quality_reason_for_defects
(
"client_server_id" smallint,
"id" integer,
"name" varchar(61),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
