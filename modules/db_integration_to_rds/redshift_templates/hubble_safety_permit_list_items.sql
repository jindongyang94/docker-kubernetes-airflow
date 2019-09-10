
create table hubble_safety_permit_list_items
(
"client_server_id" smallint,
"id" integer,
"permit_list_id" integer,
"sequence" integer,
"question" varchar(1),
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"itemable_type" varchar(1),
"itemable_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
