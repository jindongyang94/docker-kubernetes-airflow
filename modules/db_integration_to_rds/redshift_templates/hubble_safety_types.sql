
create table hubble_safety_types
(
"client_server_id" smallint,
"id" integer,
"category" varchar(6),
"name" varchar(226),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"subcategory" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
