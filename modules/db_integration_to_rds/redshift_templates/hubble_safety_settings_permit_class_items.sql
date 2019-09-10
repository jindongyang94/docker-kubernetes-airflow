
create table hubble_safety_settings_permit_class_items
(
"client_server_id" smallint,
"id" integer,
"sequence" integer,
"question" varchar(421),
"active" boolean,
"permit_class_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
