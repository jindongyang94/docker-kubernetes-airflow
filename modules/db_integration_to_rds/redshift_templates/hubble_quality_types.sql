
create table hubble_quality_types
(
"client_server_id" smallint,
"id" integer,
"category" varchar(13),
"name" varchar(156),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"subcategory" varchar(43),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
