
create table hubble_safety_permit_class_items
(
"client_server_id" smallint,
"id" integer,
"permit_class_id" integer,
"question" varchar(400),
"answer" varchar(505),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"sequence" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
