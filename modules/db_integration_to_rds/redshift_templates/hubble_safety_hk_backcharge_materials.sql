
create table hubble_safety_hk_backcharge_materials
(
"client_server_id" smallint,
"id" integer,
"description" varchar(1),
"qty" integer,
"hk_request_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
