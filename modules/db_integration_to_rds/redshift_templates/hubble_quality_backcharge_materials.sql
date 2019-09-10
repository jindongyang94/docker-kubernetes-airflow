
create table hubble_quality_backcharge_materials
(
"client_server_id" smallint,
"id" integer,
"qa_request_id" integer,
"description" varchar(12),
"qty" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
