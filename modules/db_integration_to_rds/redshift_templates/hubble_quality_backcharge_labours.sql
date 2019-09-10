
create table hubble_quality_backcharge_labours
(
"client_server_id" smallint,
"id" integer,
"qa_request_id" integer,
"category" varchar(10),
"qty" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"start_time" timestamp without time zone,
"end_time" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
