
create table hubble_quality_pins
(
"client_server_id" smallint,
"id" integer,
"defect_id" integer,
"x" numeric,
"y" numeric,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
