
create table hubble_safety_hk_backcharge_labours
(
"client_server_id" smallint,
"id" integer,
"category" varchar(1),
"start_time" timestamp without time zone,
"end_time" timestamp without time zone,
"hk_request_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
